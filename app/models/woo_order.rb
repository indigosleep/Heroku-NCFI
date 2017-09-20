require "woocommerce_api"

class WooOrder < ApplicationRecord

  has_many :woo_line_items

  has_many :woo_shipping_addresses

  # has_many :fulfillments
  # accepts_nested_attributes_for :fulfillments

  has_many :woo_acknowledgements
  has_many :woo_shipnotices




  after_create #:make_shipping_address, :transmit_to_barnhardt



  # after_initialize do |order|
  #   woocommerce = WooCommerce::API.new(
  #   "http://example.com",
  #     "#{ENV['WOO_CONSUMER_KEY']}",
  #     "#{ENV['WOO_CONSUMER_SECRET']}",
  #     {
  #       wp_api: true,
  #       version: "wc/v1"
  #     }
  #   )
  # end
end
