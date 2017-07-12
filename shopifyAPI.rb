require 'shopify_api'
SHOPIFY_API_KEY = ENV["SHOPIFY_API_KEY"]
SHOPIFY_PASSWORD = ENV["SHOPIFY_PASSWORD"]
SHOPIFY_SHOP_NAME = ENV["SHOPIFY_SHOP_NAME"]

shop_url = "https://#{SHOPIFY_API_KEY}:#{SHOPIFY_PASSWORD}@#{SHOPIFY_SHOP_NAME}.myshopify.com/admin"
ShopifyAPI::Base.site = shop_url

shop = ShopifyAPI::Shop.current

# p ShopifyAPI::Order.first.line_items.first.fulfillment_status

# p ShopifyAPI::Order.last.line_items#.shipping_lines
#
# p ShopifyAPI::Order.last.fulfillments << ShopifyAPI::Fulfillment.new(status: "open", order_id: lastID).save

p ShopifyAPI::Order.last


# p ShopifyAPI::Order.find(5222827460)
