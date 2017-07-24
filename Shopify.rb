require 'shopify_api'
require_relative 'zenTicket'
# require 'HTTParty'
# require 'base64'

class Shopify
  SHOPIFY_API_KEY = ENV["SHOPIFY_API_KEY"]
  SHOPIFY_PASSWORD = ENV["SHOPIFY_PASSWORD"]
  SHOPIFY_SHOP_NAME = ENV["SHOPIFY_SHOP_NAME"]

  def initialize
    shop_url = "https://#{SHOPIFY_API_KEY}:#{SHOPIFY_PASSWORD}@#{SHOPIFY_SHOP_NAME}.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
  end

  def makeFulfillment(order)

    shopifyOrder = ShopifyAPI::Order.find(order.shopifyID)

    line_items = []
    order.line_items.each do |li|
      line_item = {}
      line_item[:fulfillable_quantity] = 999,
      line_item[:fulfillment_service] = li.fulfillment_service,
      line_item[:fulfillment_status] = 'null',
      line_item[:grams] = li.grams,
      line_item[:id] = li.shopifyID,
      line_item[:price] = li.price,
      line_item[:product_id] = li.product_id,
      line_item[:quantity] = 1,
      line_item[:requires_shipping] = true,
      line_item[:sku] = li.sku,
      line_item[:title] = li.title,
      line_item[:variant_id] = li.variant_id,
      line_item[:variant_title] = li.variant_title,
      line_item[:vendor] = "IndigoSleep",
      line_item[:name] = li.name,
      line_item[:shipment_status] = "confirmed",
      line_item[:variant_inventory_management] = li.variant_inventory_management,
      line_item[:properties] = "[ ]",
      line_item[:product_exists] = true

      line_items << line_item
    end

    newFulfillment = ShopifyAPI::Fulfillment.new(
      notify_customer: true,
      order_id: order.shopifyID,
      tracking_company: "FedEx",
      # tracking_numbers: [notice.tracking],
      tracking_number: notice.tracking,
      tracking_urls: [notice.url]
    ).save
    #save fullfilment id to local order table
    order.fulfillments << newFulfillment
  end


  def sendShipNotice(order, notice)
    f = ShopifyAPI::Fulfillment.new(order_id: order.shopifyID)
    f.notify_customer = true
    f.tracking_company = "Fedex"
    f.tracking_number = notice[:tracking]
    f.tracking_urls = [notice[:url]]
    f.tracking_url = notice[:url]

    if f.save
      puts "Successful Shopify Fulfilment"
    else
      zt = ZenTicket.new
      message = "Shopify Transmission Error"
      zt.sendError(params)
    end
    #save fullfilment id to local order table
  end

  def updateFulfillment(notice, order, line_item)
    @carrier = notice[:carrier]
    @trackingNum = notice[:tracking]
    @url = notice[:url]

    order = ShopifyAPI::Order.find(@order.shopifyID)

    if fulfillment = ShopifyAPI::Fulfillment.new(

    ).save
      order.fulfillments << fulfillment
      puts "Fulfillment Updated"
      p fulfillment
    else
      puts "Fulfillment Update Failed"
    end
  end

  def makePriceRule(discountObj)
    pr = ShopifyAPI::PriceRule.new
    pr.title = discountObj.name
    pr.target_type = "line_item"
    pr.target_selection = "all"
    pr.allocation_method = "across"
    pr.value_type = "fixed_amount"
    pr.value = "-50"
    pr.once_per_customer = true
    pr.usage_limit = nil
    pr.customer_selection = "all"
    pr.starts_at = "2017-02-01T00:00:00Z"
    pr.save
    discountObj.shopifyID = pr.id
    discountObj.save
    code = ShopifyAPI::DiscountCode.new
    code.price_rule_id = pr.id
    code.code = pr.title
    code.prefix_options = {"price_rule_id"=>pr.id, "code"=>pr.title}
    code.save
  end

  def deleteDiscount(code)
    puts "code:"
    p code
    codeToDelete = ShopifyAPI::PriceRule.find(code.shopifyID)
    p codeToDelete.destroy
  end

  def applyDiscount(id, line_id)
    cart = ShopifyAPI::Cart.find(id)
    # url = "#{API_URL_BASE}carts/#{id}.json"
    cart.line_items.first.discounts << "John S From Tampa Gave a $50 pay-it-forward toward your purchase"
    cart.save

  end

end
