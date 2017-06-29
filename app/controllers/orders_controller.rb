class OrdersController < ApplicationController
  def index

  end

  def create
    @order = Order.new(orderParams)
    puts("!!!!!!!!!!!!!!!!")
    p @order

    if @order.save
      format.json { render json: @order.to_json, status: 201 }
    else
      format.json { render json: @order.errors.full_messages.to_json, status: 422 }
    end
  end


  private
  def orderParams
    params.require(:order).permit(

      :id, :email, :closed_at, :created_at, :updated_at, :number, :note, :token, :gateway
      # null,"test":true,"total_price":"1403.00","subtotal_price":"1393.00","total_weight":0,"total_tax":"0.00","taxes_included":false,"currency":"USD","financial_status":"voided","confirmed":false,"total_discounts":"5.00","total_line_items_price":"1398.00","cart_token":null,"buyer_accepts_marketing":true,"name":"#9999","referring_site":null,"landing_site":null,"cancelled_at":"2017-06-29T12:53:58-04:00","cancel_reason":"customer","total_price_usd":null,"checkout_token":null,"reference":null,"user_id":null,"location_id":null,"source_identifier":null,"source_url":null,"processed_at":null,"device_id":null,"phone":null,"browser_ip":null,"landing_site_ref":null,"order_number":1234,"discount_codes":[],"note_attributes":[],"payment_gateway_names":["visa","bogus"],"processing_method":"","checkout_id":null,"source_name":"web","fulfillment_status":"pending","tax_lines":[],"tags":"","contact_email":"jon@doe.ca","order_status_url":null,"line_items":[{"id":866550311766439020,"variant_id":null,"title":"4everBed","quantity":1,"price":"699.00","grams":0,"sku":"","variant_title":null,"vendor":null,"fulfillment_service":"manual","product_id":9849044164,"requires_shipping":true,"taxable":true,"gift_card":false,"pre_tax_price":"699.00","name":"4everBed","variant_inventory_management":null,"properties":[],"product_exists":true,"fulfillable_quantity":1,"total_discount":"0.00","fulfillment_status":null,"tax_lines":[]},{"id":141249953214522974,"variant_id":null,"title":"4everBed","quantity":1,"price":"699.00","grams":0,"sku":"","variant_title":null,"vendor":null,"fulfillment_service":"manual","product_id":9849044164,"requires_shipping":true,"taxable":true,"gift_card":false,"pre_tax_price":"694.00","name":"4everBed","variant_inventory_management":null,"properties":[],"product_exists":true,"fulfillable_quantity":1,"total_discount":"5.00","fulfillment_status":null,"tax_lines":[]}],"shipping_lines":[{"id":271878346596884015,"title":"Generic Shipping","price":"10.00","code":null,"source":"shopify","phone":null,"requested_fulfillment_service_id":null,"delivery_category":null,"carrier_identifier":null,"tax_lines":[]}],"billing_address":{"first_name":"Bob","address1":"123 Billing Street","phone":"555-555-BILL","city":"Billtown","zip":"K2P0B0","province":"Kentucky","country":"United States","last_name":"Biller","address2":null,"company":"My Company","latitude":null,"longitude":null,"name":"Bob Biller","country_code":"US","province_code":"KY"},"shipping_address":{"first_name":"Steve","address1":"123 Shipping Street","phone":"555-555-SHIP","city":"Shippington","zip":"K2P0S0","province":"Kentucky","country":"United States","last_name":"Shipper","address2":null,"company":"Shipping Company","latitude":null,"longitude":null,"name":"Steve Shipper","country_code":"US","province_code":"KY"},"fulfillments":[],"refunds":[],"customer":{"id":115310627314723954,"email":"john@test.com","accepts_marketing":false,"created_at":null,"updated_at":null,"first_name":"John","last_name":"Smith","orders_count":0,"state":"disabled","total_spent":"0.00","last_order_id":null,"note":null,"verified_email":true,"multipass_identifier":null,"tax_exempt":false,"phone":null,"tags":"","last_order_name":null,"default_address":{"id":715243470612851245,"first_name":null,"last_name":null,"company":null,"address1":"123 Elm St.","address2":null,"city":"Ottawa","province":"Ontario","country":"Canada","zip":"K2H7A8","phone":"123-123-1234","name":"","province_code":"ON","country_code":"CA","country_name":"Canada","default":false}}

    )
  end

end
