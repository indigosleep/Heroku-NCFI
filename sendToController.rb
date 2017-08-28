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
  "X-Shopify-Hmac-Sha256": "lvN9Xxpn9e9J0O3VGEJzpEBILSXCfrR3tZ7vUWsSpMI=",
  # "Cf-Connecting-Ip": "23.227.55.110",
  # "Accept-Encoding": "gzip",
  # "Cf-Ipcountry": "CA",
  "X-Shopify-Shop-Domain": "indigo-sleep.myshopify.com",
  # "Via": "1.1 vegur",
  # "Connect-Time": "0",
  # "X-Newrelic-Transaction": "PxQPVARRWwADVgBRAggCVVUBFB8EBw8RVU4aWg1aBlEAVgsAAlQKV1cHB0NKQQlWCFxRAQNXFTs=",
  # "Connection": "close",
  "X-Shopify-Order-Id": "820982911946154508",
  # "X-Shopify-Test": "true",
  # "User-Agent": "Ruby",
  # "Content-Length": "3841",
  # "Cf-Ray": "395838d87cc123f0-IAD"
}


file = File.read("order0.json")
data_hash = JSON.parse(file)
response = HTTParty.post('https://indigosleep.herokuapp.com/api/v1/orders', headers: headers, body: data_hash)

# response = HTTParty.post('https://requestb.in/1dx1gyo1', headers: headers, body: data_hash)

p response
