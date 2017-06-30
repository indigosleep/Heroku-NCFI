class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    params.permit(

      :id,
      :email,
      :closed_at,
      :created_at,
      :updated_at,
      :number,
      :note,
      :token,
      :gateway,
      :test,
      :total_price,
      :subtotal_price,
      :total_weight,
      :total_tax,
      :taxes_included,
      :currency,
      :financial_status,
      :confirmed,
      :total_discounts,
      :total_line_items_price,
      :cart_token,
      :buyer_accepts_marketing,
      :name,
      :referring_site,
      :landing_site,
      :cancelled_at,
      :cancel_reason,
      :total_price_usd,
      :checkout_token,
      :reference,
      :user_id,
      :location_id,
      :source_identifier,
      :source_url,
      :processed_at,
      :device_id,
      # :phone,
      :browser_ip,
      :landing_site_ref,
      :order_number,
      {:discount_codes => []},
      {:note_attributes => []},
      {:payment_gateway_names => []},
      :processing_method,
      :checkout_id,
      :source_name,
      :fulfillment_status,
      {:tax_lines => []},
      :tags,
      :contact_email,
      :order_status_url,
      {:line_items => [
        :id,
        :variant_id,
        :title,
        :quantity,
        :price,
        :grams,
        :sku,
        :variant_title,
        :vendor,
        :fulfillment_service,
        :product_id,
        :requires_shipping,
        :taxable,
        :gift_card,
        :name,
        :variant_inventory_management,
        {:properties => []},
        :product_exists,
        :fulfillable_quantity,
        :total_discount,
        :fulfillment_status,
        {:tax_lines => []},
      ]},
      {:shipping_lines =>[
        :id,
        :title,
        :price,
        :code,
        :source,
        :phone,
        :requested_fulfillment_service_id,
        :delivery_category,
        :carrier_identifier,
        {:tax_lines => []},
      ]},
      {:billing_address => [
        :first_name,
        :address1,
        :phone,
        :city,
        :zip,
        :province,
        :country,
        :last_name,
        :address2,
        :company,
        :latitude,
        :longitude,
        :name,
        :country_code,
        :province_code,
      ]},
      {:shipping_address => [
        :first_name,
        :address1,
        :phone,
        :city,
        :zip,
        :province,
        :country,
        :last_name,
        :address2,
        :company,
        :latitude,
        :longitude,
        :name,
        :country_code,
        :province_code,
      ]},
      {:fulfillments => []},
      {:refunds => []},
      {:customer => [
        :id,
        :email,
        :accepts_marketing,
        :created_at,
        :updated_at,
        :first_name,
        :last_name,
        :orders_count,
        :state,
        :total_spent,
        :last_order_id,
        :note,
        :verified_email,
        :multipass_identifier,
        :tax_exempt,
        :phone,
        :tags,
        :last_order_name,
        {:default_address => [
          :id,
          :first_name,
          :last_name,
          :company,
          :address1,
          :address2,
          :city,
          :province,
          :country,
          :zip,
          :phone,
          :name,
          :province_code,
          :country_code,
          :country_name,
          :default,
        ]}
      ]}

    )
  end

end
