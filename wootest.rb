require "woocommerce_api"


wc = WooCommerce::API.new(
"https://indigosleep.com",
  "ck_6ade3ed55075d5d99492a0a540674f8814d72dda",
  "cs_05eaf86a5c4591c82ffb532d38b13b480c98c3d0",
  {
    wp_api: true,
    version: "wc/v2"
  }
)

response = wc.get "orders"

puts response.parsed_response
