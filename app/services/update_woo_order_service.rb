class UpdateWooOrderService
  
  def initialize(woo_order)
  	@woo_order = woo_order
    @client = WooCommerce::API.new("https://www.indigosleep.com",
    	ENV['WOO_CONSUMER_KEY'], 
    	ENV['WOO_CONSUMER_SECRET'],
    	{
          wp_json: true,
          version: "v2",
          debug_mode: true,
          query_string_auth: true
        }
    )
  end

  def self.call(woo_order)
  	new(woo_order).call
  end

  def call
    data = (@woo_order.payment_method == "klarna_payments") ? { order: { status: 'processing' } } : { order: { status: 'completed' } } 
  	response = @client.put("orders/#{@woo_order.woo_id}", data )
    return response
  end
end