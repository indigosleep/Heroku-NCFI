require 'HTTParty'

class BarnhardtMessage
  # BASE_URL = "https://api.barnhardt.net/v1/order"
  BASE_URL = "https://requestb.in/pja0zbpj"
  HOME_URL = "https://indigosleep.herokuapp.com/api/v1/orders"
  attr_reader :order

  def initialize(shopifyOrder)
    shipAddress = shopifyOrder.shipping_addresses.last
    orderBody = makeOrder(shopifyOrder, shipAddress)
    headers = makeHeaders
    sendMessage(headers, orderBody)
  end

  def skuConvert(indigoSku)
    barnhardtSkus = {
      "C-MAT-TW-01": "IND-CL-TW",
      "C-MAT-TX-01": "IND-CL-TL",
      "C-MAT-FL-01": "IND-CL-FU",
      "C-MAT-QU-01": "IND-CL-QU",
      "C-MAT-KG-01": "IND-CL-KG",
      "C-MAT-CK-01": "IND-CL-CK",

      "L-MAT-TW-01": "IND-LU-TW",
      "L-MAT-TX-01": "IND-LU-TL",
      "L-MAT-FL-01": "IND-LU-FU",
      "L-MAT-QU-01": "IND-LU-QU",
      "L-MAT-KG-01": "IND-LU-KG",
      "L-MAT-CK-01": "IND-LU-CK"
    }

    return barnhardtSkus[indigoSku.to_sym]
  end

  def makeOrder(order, shipAddress)
    idString = order.id.to_s
    puts "!!!!!!!!!!!!order.id.to_s!!!!!!!!"
    puts idString

    line_items = []
    order.line_items.each do |li|

      line_item = {
        "purchase_order_line": li.id.to_s, #"203",
        "note": order.note || "",
        "product_external_id": li.sku,
        "product_id": skuConvert(li.sku),
        "quantity": li.quantity
      }
      line_items << line_item
    end

    return {
      "customer_edi_id": ENV["BARNHARDT_EDI_ID"],
      "purchase_order": order.id.to_s, #"301",
      "purchase_order_revision": 1,
      "carrier": "FDX",
      "required_date": "2018-06-10T16:30:00-07:00", #6.days.from_now.iso8601,
      "not_before_date": "2014-06-10T16:30:00-07:00",# Time.now.iso8601,
      "note": order.note || "",
      "order_lines": line_items,
      "shipTo": {
        "address1": shipAddress.address1,
        "address2": shipAddress.address2 || "",
        "address3": "",
        "city": shipAddress.city,
        "company": shipAddress.company || "",
        "country": shipAddress.country_code || "US",
        "email": order.email || "",
        "name": shipAddress.name,
        "phone": shipAddress.phone,
        "postalCode": shipAddress.zip,
        "state": shipAddress.province_code
      },
      "notification_urls": {
        "order_acknowledgement": "#{HOME_URL}/#{idString}",
        "ship_notice": "#{HOME_URL}/#{idString}"
        #ALL NOTICES GOING TO THE SAME PLACE NOW
        # TODO RECREATE HOOK: https://indigosleep.herokuapp.com/api/v1/orders
      }
    }
  end

  def makeHeaders
    return {
      "x-api-key": ENV["BARNHARDT_X_API_KEY"],
      "Content-Type"=> "application/json"
    }
  end

  def sendMessage(headers, orderBody)
    response = HTTParty.post(
    BASE_URL,
    headers: headers,
    body: orderBody.to_json
    )

    puts "BarnhardtMessageResponse!!!!!!!!!!!!!!"
    p response

  end



end
