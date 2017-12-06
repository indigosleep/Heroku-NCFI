
class WooOrdersController < ApplicationController
  before_action :parse_params

  def create
    @wooOrder = WooOrder.new(filtered_order_params(order_params))
    return if filter_pending_on_hold_status
    if @wooOrder.save
     @wooOrder = WooOrderService.call(filtered_order_params(order_params), @wooOrder)
      create_acknowledgement_shipnotice
      BarnhardtMessageWooService.call(@wooOrder)
      
      respond_to do |format|
        format.json { render json: @wooOrder.to_json, status: 201 }
      end
    else
      # TODO add ticket to zendesk
      respond_to do |format|
        format.json { render json: @wooOrder.errors.full_messages.to_json, status: 422 }
      end
    end
  end

  def update_order
    @filtered_params =  filtered_order_params(order_params)

    @wooOrder = WooOrder.find_or_initialize_by(woo_id: @filtered_params[:woo_id])
    if @wooOrder.new_record?
      @wooOrder = WooOrderService.call(@filtered_params, @wooOrder)
      if @wooOrder.save
        create_acknowledgement_shipnotice
        BarnhardtMessageWooService.call(@wooOrder)
        respond_with_201
        return
      else
        respond_with_422
        return
      end
    else
      if @wooOrder.update(@filtered_params)
        BarnhardtMessageWooService.call(@wooOrder)
        respond_with_201
      else
        respond_with_422
      end
    end
  end

  private
  # we don't want to create oder records with pending or on-hold statuses
  def filter_pending_on_hold_status
    if filtered_order_params(order_params)['status'] == 'pending' || filtered_order_params(order_params)['status'] == 'on-hold'
      respond_to do |format|
        format.json { render json: @wooOrder.to_json, status: 422 }
      end 
      return true
    else
      return false
    end
  end

  def respond_with_201
    respond_to do |format|
      format.json { render json: @wooOrder.to_json, status: 201 }
    end
  end

  def respond_with_422
    respond_to do |format|
      format.json { render json: @wooOrder.errors.full_messages.to_json, status: 422 }
    end
  end

  def respond_with_200
    respond_to do |format|
      format.json { render Json: {status: 'ok' }.to_json, status: 200 }
    end
  end

  def create_acknowledgement_shipnotice
    ack = @wooOrder.woo_acknowledgements.build()
    ack.save
    ship_notice = @wooOrder.woo_shipnotices.build()
    ship_notice.save
  end

  def parse_params
    @body = JSON.parse request.body.read
  end

  def filtered_order_params(orderParams)
    filteredParams = {}
    orderParams.each do |key, value|
     if key == "id"
        filteredParams[:woo_id] = value
      else
        filteredParams[key] = value
      end
    end
    filteredParams[:phone] = params[:billing][:phone]
    filteredParams[:email] = params[:billing][:email]

    filteredParams
  end

  def order_params
    params.permit(
      :id,
      :woo_id,
      :number,
      :parent_id,
      :order_key,
      :created_via,
      :version,
      :status,
      :currency,
      :date_created,
      :date_created_gmt,
      :date_modified,
      :date_modified_gmt,
      :discount_total,
      :discount_tax,
      :shipping_total,
      :shipping_tax,
      :cart_tax,
      :total,
      :total_tax,
      :prices_include_tax,
      :customer_id,
      :customer_ip_address,
      :customer_user_agent,
      :customer_note,
      {billing: []},
      {shipping: []},
      :payment_method,
      :payment_method_title,
      :transaction_id,
      :date_paid,
      :date_paid_gmt,
      :date_completed,
      :date_completed_gmt,
      :cart_hash,
      {meta_data: []},
      {line_items: []},
      {tax_lines: []},
      {shipping_lines: []},
      {fee_lines: []},
      {coupon_lines: []},
      {refunds: []}
    )
  end

end
