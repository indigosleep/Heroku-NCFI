class UpdateWooOrderService
  
  def initialize(woo_id)
  	@woo_id = woo_id
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

  def self.call(woo_id)
  	new(woo_id).call
  end

  def call
    data = { order: { status: 'completed' } }
  	response = @client.put("orders/#{@woo_id}", data )
    Rails.logger.info "************ response update woo order: #{response} *******************"
    return response
  end
end