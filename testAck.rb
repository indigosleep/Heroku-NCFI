require 'HTTParty'

# BASE_URL = "http://localhost:3000/api/v1/orders"
BASE_URL = "https://sawyermerchant.pagekite.me/api/v1/acknowledgements/2.json"
# BASE_URL = "https://requestb.in/pja0zbpj"

body =
  {
  "customer_edi_id": "402100100554",
  "purchase_order": "4",
  "order_number": "Bhrt#",
  "status": "Ping",
  "errors": [
      {
        "message": "bad thing",
        "type": "thing"
      }
    ]
  }


headers = {
  "Content-Type"=> "application/json"
}


response = HTTParty.put(
  BASE_URL,
  headers: headers,
  body: body.to_json
)


p response
