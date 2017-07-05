require 'shopify_api'
# require 'HTTParty'
require_relative '../../BarnhardtMessage'
SHOPIFY_API_KEY = "e1c86625102fe6d8f9b157ef0cc41965"
SHOPIFY_PASSWORD = "0fcef94cc5e4cfde2d4a097e992a9cfe"
SHOP_NAME = "indigo-sleep"

shop_url = "https://#{SHOPIFY_API_KEY}:#{SHOPIFY_PASSWORD}@#{SHOP_NAME}.myshopify.com/admin"
ShopifyAPI::Base.site = shop_url

shop = ShopifyAPI::Shop.current


class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end



  def create

    if existingOrder = Order.find_by(shopifyID: params[:id])

      if existingOrder.update(filteredOrderParams(orderParams))
        respond_to do |format|
          format.json { render json: existingOrder.to_json, status: 201 }
          puts ("UPDATED!!!!!!!!!!!!!!!!!")
        end
      else
        respond_to do |format|
          format.json { render json: existingOrder.errors.full_messages.to_json, status: 422 }
        end
      end

    else

      @order = Order.new(filteredOrderParams(orderParams))

      if @order.save

        params[:line_items].each do |lineItem|
          @order.line_items.build(
          # lineItemParams
            shopifyID: lineItem[:id],
            title: lineItem[:title],
            quantity: lineItem[:quantity],
            price: lineItem[:price],
            sku: lineItem[:sku],
            fulfillment_service: lineItem[:fulfillment_service],
            product_id: lineItem[:product_id],
            name: lineItem[:name],
            properties: lineItem[:properties],
            fulfillment_status: lineItem[:fulfillment_status]
          ).save
        end

        @order.shipping_addresses.build(shippingAddressParams).save

        BarnhardtMessage.new(@order)

        respond_to do |format|
          format.json { render json: @order.to_json, status: 201 }
        end
      else
        respond_to do |format|
          format.json { render json: @order.errors.full_messages.to_json, status: 422 }
        end
      end

    end

  end


  private

  def filteredOrderParams(orderParams)
    filteredParams = {}
    orderParams.each do |key, value|
      # puts "??????????????"
      # puts "key"
      # p key
      # puts "value"
      # p value
      # puts "??????????????????"
      if key == "id"
        puts "Change ID!!!!!!!!!!!!!"
        filteredParams[:shopifyID] = value
      else
        filteredParams[key] = value
      end
    end
    puts "filteredParams"
    p filteredParams
    filteredParams
  end

  def shippingAddressParams
    params.require(:shipping_address).permit(
      :name,
      :address1,
      :phone,
      :city,
      :zip,
      :province_code,
      :province,
      :country,
      :country_code,
      :address2,
      :company,
      :fulfillments,
      :refunds
    )
  end

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
        {:tax_lines => []}
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

      # {:fulfillments => []},
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
      ]},
      # line_item_attributes: [
      #
      #   params[:line_items][:id],
      #   :line_items[:title],
      #   :line_items[:quantity],
      #   :line_items[:price],
      #   :line_items[:sku],
      #   :line_items[:fulfillment_service],
      #   :line_items[:product_id],
      #   :line_items[:name],
      #   :line_items[:properties],
      #   :line_items[:fulfillment_status],
      #
      # ],
      #
      # shipping_address_attributes: [
      #   :shipping_address["name"],
      #   :shipping_address["address1"],
      #   :shipping_address["phone"],
      #   :shipping_address["city"],
      #   :shipping_address["zip"],
      #   :shipping_address["province_code"], #state
      #   :shipping_address["province"], #state
      #   :shipping_address["country_code"],
      #   :shipping_address["address2"],
      #   :shipping_address["company"],
      #   :shipping_address["fulfillments"],
      #   :shipping_address["refunds"],
      # ],

    )
  end

end
