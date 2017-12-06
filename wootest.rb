require "woocommerce_api"


wc = WooCommerce::API.new(
"https://www.indigosleep.com",
  "ck_4df93d504aa6cde275669e93528736c0e9049198",
  "cs_d9198fd0dab7aa179b725400350ed0bc190b686e",
  # "ck_c2ccd88be381d8f62abc83f7d2a8cf3068a08d25",
  # "cs_8222b579cf2c66835b1f144663675c277ec1895c",
  {
    wp_json: true,
    version: "wc/v2",
    query_string_auth: true #// Force Basic Authentication as query string true and using under HTTPS
  }
)
response = wc.get("orders/3186")

puts response
