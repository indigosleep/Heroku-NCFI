
class WooOrdersController < ApplicationController
  before_action :parse_params

  def create
    @wooOrder = WooOrder.new(filtered_order_params(order_params))
    return if filter_pending_status
    if @wooOrder.save
     @wooOrder = WooOrderService.call(params, @wooOrder)
      ack = @wooOrder.woo_acknowledgements.build()
      ack.save
      ship_notice = @wooOrder.woo_shipnotices.build()
      ship_notice.save
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
      @wooOrder = WooOrderService.call(params, @wooOrder)
      if @wooOrder.save
        ack = @wooOrder.woo_acknowledgements.build()
        ack.save
        ship_notice = @wooOrder.woo_shipnotices.build()
        ship_notice.save
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

  # def filteredAddressParams(addressParams)
  #   filteredParams = {}
  #   addressParams.each do |key, value|
  #     if key == "address_1"
  #       filteredParams[:address1] = value
  #     elsif key == "address_2"
  #       filteredParams[:address2] = value
  #     elsif key == "city"
  #       filteredParams[:province] = value
  #     elsif key == "postcode"
  #       filteredParams[:zip] = value
  #     else
  #       filteredParams[:key] = value
  #     end
  #   end
  #   filteredParams
  # end
  def filter_pending_status
    if filtered_order_params(order_params)['status'] == 'pending'
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


  # SIZES = {
  #   "twin":             "TW",
  #   "twin-xl":          "TX",
  #   "full":             "FL",
  #   "queen":            "QU",
  #   "king":             "KG",
  #   "california-king":  "CK"
  # }

  # def getSize(size)
  #   SIZES[size.to_sym]
  # end


  # def buildSku(meta_data)
  #   sku = ""
  #   sku += meta_data[0][:value][0].capitalize
  #   sku += "-MAT-"
  #   size = getSize(meta_data[1][:value])
  #   sku += size
  #   sku += "-01"
  #   puts "sku is #{sku} %%%%%%%%%%%%%%%%%%%%%"
  #   sku
  # end

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
