require "woocommerce_api"


wc = WooCommerce::API.new(
"https://www.indigosleep.com",
  "ck_6ade3ed55075d5d99492a0a540674f8814d72dda",
  "cs_05eaf86a5c4591c82ffb532d38b13b480c98c3d0",
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
