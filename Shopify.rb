require 'shopify_api'

class Shopify
  SHOPIFY_API_KEY = ENV["SHOPIFY_API_KEY"]
  SHOPIFY_PASSWORD = ENV["SHOPIFY_PASSWORD"]
  SHOPIFY_SHOP_NAME = ENV["SHOPIFY_SHOP_NAME"]

  def initialize
    shop_url = "https://#{API_KEY}:#{PASSWORD}@#{SHOP_NAME}.myshopify.com/admin"
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
      # status: "open",
      # line_items: line_items,
      notify_customer: true,
      order_id: order.shopifyID,
      # receipt: [
      #   {
      #     testcase: true,
      #     authroization: 1
      #   }
      # ],
      tracking_company: "FedEx",
      # tracking_numbers: [notice.tracking],
      tracking_number: notice.tracking,
      tracking_urls: [notice.url]
    ).save

    #save fullfilment id to local order table

    order.fulfillments << newFulfillment
  end

  # def sendShipNotice(order, notice)
  #   shopifyOrder = ShopifyAPI::Order.find(order.shopifyID)
  #   newFulfillment = ShopifyAPI::Fulfillment.new(
  #     status: "success",
  #     line_items: [
  #       shipment_status: "in_transit"
  #     ],
  #     notify_customer: true,
  #     order_id: order.shopifyID,
  #     tracking_company: "FedEx",
  #     tracking_numbers: notice[:tracking],
  #     tracking_urls: notice[:url]
  #   ).save
  #   order.fulfillments << newFulfillment
  # end

  def sendShipNotice(order, notice)

    # shopifyOrder = ShopifyAPI::Order.find(order.shopifyID)

    # line_items = []
    # order.line_items.each do |li|
    #   line_item = {}
    #   line_item[:fulfillable_quantity] = 999
    #   line_item[:fulfillment_service] = li.fulfillment_service
    #   # line_item[:fulfillment_status] = null
    #   line_item[:grams] = li.grams
    #   line_item[:id] = li.shopifyID
    #   line_item[:price] = li.price
    #   line_item[:product_id] = li.product_id
    #   line_item[:quantity] = 1
    #   line_item[:requires_shipping] = true
    #   line_item[:sku] = li.sku
    #   line_item[:title] = li.title
    #   line_item[:variant_id] = li.variant_id
    #   line_item[:variant_title] = li.variant_title
    #   line_item[:vendor] = "IndigoSleep"
    #   line_item[:name] = li.name
    #   line_item[:shipment_status] = "in_transit"
    #   line_item[:variant_inventory_management] = li.variant_inventory_management
    #   line_item[:properties] = "[ ]"
    #   line_item[:product_exists] = true
    #
    #   line_items << line_item
    # end


    # newFulfillment = ShopifyAPI::Fulfillment.new(
    #   status: "open",
    #   line_items: [],#line_items,
    #   notify_customer: true,
    #   order_id: order.shopifyID,
    #   tracking_company: "FedEx",
    #   tracking_numbers: [notice[:tracking]],
    #   tracking_urls: [notice[:url]]
    # ).save

    f = ShopifyAPI::Fulfillment.new(order_id: order.shopifyID)
    # f.line_items = line_items
    # f.status = "open"
    f.notify_customer = true
    f.tracking_company = "Fedex"
    # f.tracking_numbers = [notice[:tracking]]
    f.tracking_number = notice[:tracking]
    f.tracking_urls = [notice[:url]]
    f.save

    #save fullfilment id to local order table


    # shopifyOrder.fulfillments << newFulfillment
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


end
