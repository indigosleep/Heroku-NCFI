require 'HTTParty'

BASE_URL = "http://indigosleep.herokuapp.com/api/v1/shipnotices/31.json"
# BASE_URL = "https://sawyermerchant.pagekite.me/api/v1/shipnotices/45.json"

body =
  {
  "customer_edi_id": "402100100554",
  "purchase_order": "801",
  "purchase_order_line": "33",
  "tracking": [
    {
      "carrier": "FDX",
      "tracking": "111111111111",
      "url": "https://www.fedex.com/apps/fedextrack/?action=track&tracknumbers=111111111111"
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
