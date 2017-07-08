require 'HTTParty'

BASE_URL = "https://api.barnhardt.net/v1/order"


headers = {
  "x-api-key": ENV["BARNHARDT_X_API_KEY"],
  "Content-Type"=> "application/json"
}

orders = HTTParty.get(
BASE_URL,
headers: headers
)

p orders
