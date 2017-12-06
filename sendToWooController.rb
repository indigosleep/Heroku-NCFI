require 'HTTParty'
require 'json'

headers = {
  "X-Request-Id": "eb50eacb-42d5-4a50-99e4-78640477c2be",
  # "Cf-Visitor": "{scheme:https}",
  # "Accept": "*/*",
  "Content-Type": "application/json",
  # "Total-Route-Time": "0",
  # "X-Newrelic-Id": "VQQUUFNS",
  # "X-Shopify-Topic": "orders/create",
  # "X-Shopify-Hmac-Sha256": "lvN9Xxpn9e9J0O3VGEJzpEBILSXCfrR3tZ7vUWsSpMI=",
  # "Cf-Connecting-Ip": "23.227.55.110",
  # "Accept-Encoding": "gzip",
  # "Cf-Ipcountry": "CA",
  # "X-Shopify-Shop-Domain": "indigo-sleep.myshopify.com",
  # "Via": "1.1 vegur",
  # "Connect-Time": "0",
  # "X-Newrelic-Transaction": "PxQPVARRWwADVgBRAggCVVUBFB8EBw8RVU4aWg1aBlEAVgsAAlQKV1cHB0NKQQlWCFxRAQNXFTs=",
  # "Connection": "close",
  # "X-Shopify-Order-Id": "820982911946154508",
  # "X-Shopify-Test": "true",
  # "User-Agent": "Ruby",
  # "Content-Length": "3841",
  # "Cf-Ray": "395838d87cc123f0-IAD"
}

id = Random.rand(10000)
processing = '{"id":123435399,"parent_id":0,"number":"3520","order_key":"wc_order_5a22ff49eb542","created_via":"checkout","version":"3.1.2","status":"processing","currency":"USD","date_created":"2017-12-02T14:30:17","date_created_gmt":"2017-12-02T19:30:17","date_modified":"2017-12-02T14:33:48","date_modified_gmt":"2017-12-02T19:33:48","discount_total":"0.00","discount_tax":"0.00","shipping_total":"0.00","shipping_tax":"0.00","cart_tax":"0.00","total":"549.00","total_tax":"0.00","prices_include_tax":false,"customer_id":141,"customer_ip_address":"172.58.159.97","customer_user_agent":"mozilla\/5.0 (iphone; cpu iphone os 11_1_2 like mac os x) applewebkit\/604.1.34 (khtml, like gecko) crios\/62.0.3202.70 mobile\/15b202 safari\/604.1","customer_note":"","billing":{"first_name":"Dee","last_name":"Brooks","company":"","address_1":"204 Netherland Ln","address_2":"","city":"Simpsonville","state":"SC","postcode":"29681","country":"US","email":"Deejustin@icloud.com","phone":"8648041986"},"shipping":{"first_name":"Dee","last_name":"Brooks","company":"","address_1":"204 Netherland Ln","address_2":"","city":"Simpsonville","state":"SC","postcode":"29681","country":"US"},"payment_method":"klarna_payments","payment_method_title":"Pay Over Time","transaction_id":"0720b05d-c8f2-5d22-9519-17d7ba135cda","date_paid":"2017-12-02T14:33:48","date_paid_gmt":"2017-12-02T19:33:48","date_completed":null,"date_completed_gmt":null,"cart_hash":"ba4e1bc4817840891655251b860c018e","meta_data":[{"id":74511,"key":"taptap-hide-checkbox","value":""},{"id":74558,"key":"_download_permissions_granted","value":"yes"},{"id":74561,"key":"_wc_klarna_order_id","value":"0720b05d-c8f2-5d22-9519-17d7ba135cda"},{"id":74562,"key":"_wc_klarna_environment","value":"live"},{"id":74563,"key":"_wc_klarna_country","value":"US"}],"line_items":[{"id":922,"name":"Comfort Always\u00ae Classic Mattress - Queen","product_id":3024,"variation_id":3050,"quantity":1,"tax_class":"","subtotal":"549.00","subtotal_tax":"0.00","total":"549.00","total_tax":"0.00","taxes":[],"meta_data":[{"id":7100,"key":"pa_mattress-size","value":"queen"}],"sku":"C-MAT-QU-01","price":549}],"tax_lines":[],"shipping_lines":[{"id":923,"method_title":"Free shipping","method_id":"free_shipping:1","total":"0.00","total_tax":"0.00","taxes":[],"meta_data":[{"id":7105,"key":"Items","value":"Comfort Always\u00ae Classic Mattress - Queen × 1"}]}],"fee_lines":[],"coupon_lines":[],"refunds":[]}'
pending = '{"id":12345698,"parent_id":0,"number":"3520","order_key":"wc_order_5a22ff49eb542","created_via":"checkout","version":"3.1.2","status":"pending","currency":"USD","date_created":"2017-12-02T14:30:17","date_created_gmt":"2017-12-02T19:30:17","date_modified":"2017-12-02T14:33:48","date_modified_gmt":"2017-12-02T19:33:48","discount_total":"0.00","discount_tax":"0.00","shipping_total":"0.00","shipping_tax":"0.00","cart_tax":"0.00","total":"549.00","total_tax":"0.00","prices_include_tax":false,"customer_id":141,"customer_ip_address":"172.58.159.97","customer_user_agent":"mozilla\/5.0 (iphone; cpu iphone os 11_1_2 like mac os x) applewebkit\/604.1.34 (khtml, like gecko) crios\/62.0.3202.70 mobile\/15b202 safari\/604.1","customer_note":"","billing":{"first_name":"Dee","last_name":"Brooks","company":"","address_1":"204 Netherland Ln","address_2":"","city":"Simpsonville","state":"SC","postcode":"29681","country":"US","email":"Deejustin@icloud.com","phone":"8648041986"},"shipping":{"first_name":"Dee","last_name":"Brooks","company":"","address_1":"204 Netherland Ln","address_2":"","city":"Simpsonville","state":"SC","postcode":"29681","country":"US"},"payment_method":"klarna_payments","payment_method_title":"Pay Over Time","transaction_id":"0720b05d-c8f2-5d22-9519-17d7ba135cda","date_paid":"2017-12-02T14:33:48","date_paid_gmt":"2017-12-02T19:33:48","date_completed":null,"date_completed_gmt":null,"cart_hash":"ba4e1bc4817840891655251b860c018e","meta_data":[{"id":74511,"key":"taptap-hide-checkbox","value":""},{"id":74558,"key":"_download_permissions_granted","value":"yes"},{"id":74561,"key":"_wc_klarna_order_id","value":"0720b05d-c8f2-5d22-9519-17d7ba135cda"},{"id":74562,"key":"_wc_klarna_environment","value":"live"},{"id":74563,"key":"_wc_klarna_country","value":"US"}],"line_items":[{"id":922,"name":"Comfort Always\u00ae Classic Mattress - Queen","product_id":3024,"variation_id":3050,"quantity":1,"tax_class":"","subtotal":"549.00","subtotal_tax":"0.00","total":"549.00","total_tax":"0.00","taxes":[],"meta_data":[{"id":7100,"key":"pa_mattress-size","value":"queen"}],"sku":"C-MAT-QU-01","price":549}],"tax_lines":[],"shipping_lines":[{"id":923,"method_title":"Free shipping","method_id":"free_shipping:1","total":"0.00","total_tax":"0.00","taxes":[],"meta_data":[{"id":7105,"key":"Items","value":"Comfort Always\u00ae Classic Mattress - Queen × 1"}]}],"fee_lines":[],"coupon_lines":[],"refunds":[]}'
# data_hash = JSON.parse(file)
# response = HTTParty.post('https://indigosleep.herokuapp.com/api/v1/woo_orders', headers: headers, body: data_hash)
response = HTTParty.post('http://localhost:3000/api/v1/woo_orders.json', headers: headers, body: processing)
# response = HTTParty.post('https://requestb.in/1dx1gyo1', headers: headers, body: data_hash)

p response