class WooOrderService
  

  def initialize(parameters, order)
    @wooOrder = order
    @params = parameters
  end

  def self.call(parameters, order)
    new(parameters, order).call
  end

  def call 
    @params[:line_items].each do |lineItem|
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

      if @params[:shipping][:address_1] != ""
        @wooOrder.woo_shipping_addresses.build(shippingAddressParams).save
        puts "Primary Address Input"
      else
        @wooOrder.woo_shipping_addresses.build(billingAddressParams).save
        puts "Secondary Address Input"
      end
      return @wooOrder
  end


  private

  def billingAddressParams
    @params.require(:billing).permit(
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
    @params.require(:shipping).permit(
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


end