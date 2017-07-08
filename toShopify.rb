require "base64"
# require 'HTTParty'

BASE_URL = "https://indigo-sleep.myshopify.com/admin/orders/"

KEYS = Base64.encode64( "e1c86625102fe6d8f9b157ef0cc41965:0fcef94cc5e4cfde2d4a097e992a9cfe")

body = {
  # "fulfillment_status": "fulfilled"
  }.to_json

headers = {
  "Content-Type"=> "application/json",
  "Authorization"=> "Basic #{KEYS}"
}

# response = HTTParty.post(
#   "#{BASE_URL}1001.json",
#   # "https://requestb.in/15k4xzq1",
#   headers: headers,
#   body: body
# )
#
#
# p response

puts KEYS

puts "!"

puts Base64.decode64("ZTFjODY2MjUxMDJmZTZkOGY5YjE1N2VmMGNjNDE5NjU6MGZjZWY5NGNjNWU0
Y2ZkZTJkNGEwOTdlOTkyYTljZmU=")
