require "woocommerce_api"


wc = WooCommerce::API.new(
"https://www.indigosleep.com",
    	ENV['WOO_CONSUMER_KEY'], 
    	ENV['WOO_CONSUMER_SECRET'],

    wp_json: true,
    version: "v2",
    query_string_auth: true, #// Force Basic Authentication as query string true and using under HTTPS
    debug_mode: true
  }
)
response = wc.get("orders/3186")

puts response
