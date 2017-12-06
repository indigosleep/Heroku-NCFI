class UpdateWooOrderService
  
  def initialize(woo_order)
  	@woo_order = woo_order
    @client = WooCommerce::API.new("https://www.indigosleep.com",
    	ENV['WOO_CONSUMER_KEY'], 
    	ENV['WOO_CONSUMER_SECRET'],
    	{
          wp_json: true,
          version: "wc/v2"
          # ,query_string_auth: true #// Force Basic Authentication as query string true and using under HTTPS
        }
    )
  end

  def self.call(woo_order)
  	new(woo_order).call
  end

  def call
  	response = @client.put("orders/#{@woo_order.woo_id}", { status: 'completed' } )
    return response
  end
end