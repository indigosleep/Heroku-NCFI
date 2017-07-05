require 'shopify_api'
API_KEY = "e1c86625102fe6d8f9b157ef0cc41965"
PASSWORD = "0fcef94cc5e4cfde2d4a097e992a9cfe"
SHOP_NAME = "indigo-sleep"

shop_url = "https://#{API_KEY}:#{PASSWORD}@#{SHOP_NAME}.myshopify.com/admin"
ShopifyAPI::Base.site = shop_url

shop = ShopifyAPI::Shop.current

# p ShopifyAPI::Order.first.line_items.first.fulfillment_status

p ShopifyAPI::Order.last.line_items#.shipping_lines
#
# p ShopifyAPI::Order.last.fulfillments << ShopifyAPI::Fulfillment.new(status: "open", order_id: lastID).save

# p ShopifyAPI::Order.last.fulfillments


# p ShopifyAPI::Order.find(5222827460)
