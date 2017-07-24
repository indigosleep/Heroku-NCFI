require 'shopify_api'
require 'base64'
# require 'HTTParty'
require_relative '../../BarnhardtMessage'
require_relative '../../Shopify'

SHOPIFY_API_KEY = ENV["SHOPIFY_API_KEY"]
SHOPIFY_PASSWORD = ENV["SHOPIFY_PASSWORD"]
SHOPIFY_SHOP_NAME = ENV["SHOPIFY_SHOP_NAME"]
SHARED_SECRET = ENV["SHOPIFY_SHARED_SECRET"]
TEST_HOOK_SECRET = "8c3f7ef6c9344daeca59a1fa170aa5716d71865f928db62b0b887bca1c32ff20"

shop_url = "https://#{SHOPIFY_API_KEY}:#{SHOPIFY_PASSWORD}@#{SHOPIFY_SHOP_NAME}.myshopify.com/admin"
ShopifyAPI::Base.site = shop_url

shop = ShopifyAPI::Shop.current


class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :verify_webhook, only: [:create]

  def index
  end



  def create
    request.body.rewind
    data = request.body.read
    headDigest = request.headers["X-Shopify-Hmac-Sha256"]
    verified = verify_webhook(data, headDigest)

    if verified
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
          Discount.destroy_all

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

            if lineItem[:sku][-3..-1] == "PSF"
              #create a discount
              discount = Discount.new() #local object
              p firstName = params[:customer][:first_name]
              p lastInitial = params[:customer][:last_name][0]
              p city = params[:shipping_address][:city]
              discount.name = "#{firstName} #{lastInitial} from #{city} gave you a $50 PaySleepForward"
              discount.save
              shopify = Shopify.new
              shopify.makePriceRule(discount.name)
            end
          end

          if params[:shipping_address]
            @order.shipping_addresses.build(shippingAddressParams).save
            puts "Primary Address Input"
          else
            @order.shipping_addresses.build(customerShippingAddressParams).save
            puts "Secondary Address Input"
          end

          ack = @order.acknowledgements.build()
          ack.save
          ackNum = ack.id

          ship_notice = @order.shipnotices.build()
          ship_notice.save
          sNoteNum = ship_notice.id
          # byebug
          BarnhardtMessage.new(@order, ackNum, sNoteNum)
          #TODO don't update shopify w/o Barnhardt
          # shopify = Shopify.new
          # shopify.makeFulfillment(@order)

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

  end


  private


  def verify_webhook(data, hmac_header)
    digest  = OpenSSL::Digest::Digest.new('sha256')
    test_calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, TEST_HOOK_SECRET, data)).strip
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, SHARED_SECRET, data)).strip

    if ActiveSupport::SecurityUtils.secure_compare(test_calculated_hmac, hmac_header)
      puts "Test Mode Message"
      return true
    elsif ActiveSupport::SecurityUtils.secure_compare(calculated_hmac, hmac_header)
      puts "Live Message"
      return true
    else
      puts "Base64 Digest Mismatch"
      return false
    end

  end

  def filteredOrderParams(orderParams)
    filteredParams = {}
    orderParams.each do |key, value|
      if key == "id"
        filteredParams[:shopifyID] = value
      else
        filteredParams[key] = value
      end
    end
    filteredParams
  end

  def customerShippingAddressParams
    params.require(:order).require(:customer).require(:default_address).permit(

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
      # :country_name,
      # :default
    )
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
