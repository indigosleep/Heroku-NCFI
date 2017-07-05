require 'HTTParty'

BASE_URL = "http://localhost:3000/api/v1/orders"

body =
  {"id":820982911946154508,"email":"jon@doe.ca"}.to_json


headers = {
  "Content-Type"=> "application/json"
}


response = HTTParty.post(
  BASE_URL,
  headers: headers,
  body: body
)


p response
