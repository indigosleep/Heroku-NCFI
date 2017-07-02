require 'HTTParty'

BASE_URL = "https://api.barnhardt.net/v1/order"

order = {
    "customer_edi_id": "402100100554",
    "purchase_order": "777",
    "purchase_order_revision": 1,
    "carrier": "FDX",
    "required_date": "2018-06-10T16:30:00-07:00",
    "not_before_date": "2014-06-10T16:30:00-07:00",
    "note": "test string",
    "order_lines": [
      {
        "purchase_order_line": "1a",
        "note": "teststring",
        "product_external_id": "IND-CL-TW",
        "product_id": "IND-CL-TW",
        "quantity": 1
      }
    ],
    "shipTo": {
      "address1": "2422 W Mississippi Pl",
      "address2": "",
      "address3": "",
      "city": "Tampa",
      "company": "",
      "country": "USA",
      "email": "sawyermerchant@gmail.com",
      "name": "John Sawyer",
      "phone": "8138331753",
      "postalCode": "33613",
      "state": "FL"
    },
    "notification_urls": {
      "order_acknowledgement": "https://requestb.in/15k4xzq1"
    }
  }.to_json

headers = {
  "x-api-key": "Kb3Jd2LL1o1i2Gk2DwsMz2YOeIV5Zgaw18hqoRZ2",
  "Content-Type"=> "application/json"
}

# response = HTTParty.post(
#   BASE_URL,
#   headers: headers,
#   body: order
# )
#
#
# p response

orders = HTTParty.get(
  BASE_URL,
  headers: headers
)

p orders
