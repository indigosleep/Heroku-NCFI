
class BarnhardtMessageShopify
  attr_reader :order

  TESTMODE = false
  if TESTMODE
    5.times do
      "%%%%%%TESTMODE%%%%%%%%"
    end
  end

  BASE_URL = "https://api.barnhardt.net/v1/order"
  # BASE_URL = "https://requestb.in/pja0zbpj"
  HOME_URL = "https://indigosleep.herokuapp.com/api/v1"
  # HOME_URL = "https://sawyermerchant.pagekite.me/api/v1"
  BARNHARDT_SKUS = {
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

  def initialize(shopifyOrder, ackNum, sNoteNum)
    shipAddress = shopifyOrder.shipping_addresses.last
    orderBody = makeOrder(shopifyOrder, shipAddress, ackNum, sNoteNum)
    headers = makeHeaders
    sendMessage(headers, orderBody)
  end

  def trimSku(indigoSku)
    indigoSku[0..10]
  end

  def skuConvert(indigoSku)
    trimmedIndigoSku = trimSku(indigoSku)
    return BARNHARDT_SKUS[trimmedIndigoSku.to_sym]
  end

  def makeOrder(order, shipAddress, ackNum, sNoteNum)
    idString = order.id.to_s
    line_items = []

    order.line_items.each do |li|
      trimmedIndigoSku = trimSku(li.sku)
      if BARNHARDT_SKUS.key?(trimmedIndigoSku.to_sym)
        line_item = {
          "purchase_order_line": li.id.to_s,
          "note": order.note || "",
          "product_external_id": li.sku,
          "product_id": skuConvert(li.sku),
          "quantity": li.quantity
        }
        line_items << line_item
      end
    end

    customer_edi_id = TESTMODE ? ENV["TEST_BARNHARDT_EDI_ID"] : ENV["BARNHARDT_EDI_ID"]

    return {
      "customer_edi_id": customer_edi_id,
      "purchase_order": order.id.to_s,
      "purchase_order_revision": 1,
      "carrier": "FDX",
      "required_date": 6.days.from_now.iso8601,
      "not_before_date": Time.now.iso8601,
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
        "order_acknowledgement": "#{HOME_URL}/acknowledgements/#{ackNum}.json",
        "ship_notice": "#{HOME_URL}/shipnotices/#{sNoteNum}.json"

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
    puts "To Barnhardt"
    p orderBody
    response = HTTParty.post(
    BASE_URL,
    headers: headers,
    body: orderBody.to_json
    )

    puts "BarnhardtMessageResponse!!!!!!!!!!!!!!"
    p response

  end



end
