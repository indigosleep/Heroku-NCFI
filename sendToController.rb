# require 'HTTParty'

nums = [0,1]

nums.each do |n|

file = File.read('order0.json')

response = HTTParty.post('localhost:3000/api/v1/orders', )
