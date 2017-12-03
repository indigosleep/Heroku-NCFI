
class WooOrdersController < ApplicationController
  before_action :parse_params

  def create
    @wooOrder = WooOrder.new(filtered_order_params(order_params))
    if @wooOrder.save

      # params[:line_items].each do |li|
      #   puts "line itmem %%%%%%%%%%%%%%%%%%"
      #   p li
      # end

      params[:line_items].each do |lineItem|
        if lineItem[:name].include? "Pillow"
          puts "Pillow"
        else
          puts "@@@@@@@@@@@@@Building line_items@@@@@@@"
          sku = lineItem[:sku]
          @wooOrder.woo_line_items.build(
            wooID: lineItem[:id],
            name: lineItem[:name],
            product_id: lineItem[:product_id],
            variation_id: lineItem[:variation_id],
            quantity: lineItem[:quantity],
            tax_class: lineItem[:tax_class],
            subtotal: lineItem[:subtotal],
            subtotal_tax: lineItem[:subtotal_tax],
            total: lineItem[:total],
            total_tax: lineItem[:total_tax],
            taxes: lineItem[:taxes],
            meta_data: lineItem[:meta_data],
            sku: sku,
            price: lineItem[:price]
          ).save
        end
      end

      if params[:shipping][:address_1] != ""
        @wooOrder.woo_shipping_addresses.build(shippingAddressParams).save
        puts "Primary Address Input"
      else
        @wooOrder.woo_shipping_addresses.build(billingAddressParams).save
        puts "Secondary Address Input"
      end

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
    respond_to do |format|
      format.json { render status: :ok }
    end
    
    # @filtered_params =  filtered_order_params(order_params)
    # @wooOrder = WooOrder.find_by(woo_id: @filtered_params[:woo_id])
    # if @wooOrder 
    #   if @wooOrder.update(@filtered_params)
    #     BarnhardtMessageWooService.call(@wooOrder)
    #     respond_to do |format|
    #       format.json { render json: @wooOrder.to_json, status: 201 }
    #     end
    #   else
    #     respond_to do |format|
    #       format.json { render json: @wooOrder.errors.full_messages.to_json, status: 422 }
    #     end
    #   end
    # else
    #   respond_to do |format|
    #     format.json { render status: 500 }
    #   end
    # end
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

  def billingAddressParams
    params.require(:billing).permit(
      :first_name,
      :last_name,
      :company,
      :address_1,
      :address_2,
      :city,
      :state,
      :postcode,
      :country
    )
  end

  def shippingAddressParams
    params.require(:shipping).permit(
      :first_name,
      :last_name,
      :company,
      :address_1,
      :address_2,
      :city,
      :state,
      :postcode,
      :country
    )
  end

  SIZES = {
    "twin":             "TW",
    "twin-xl":          "TX",
    "full":             "FL",
    "queen":            "QU",
    "king":             "KG",
    "california-king":  "CK"
  }

  def getSize(size)
    SIZES[size.to_sym]
  end


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
    return true
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
