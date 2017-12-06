class UpdateWooShippingService
  include HTTParty
  base_uri "https://www.indigosleep.com/wp-json/wc/v1"
  def initialize(woo_id, params)
    @params = params
    @woo_id = woo_id
  end

  def self.call(woo_id, params)
  	new(woo_id, params).call
  end

  def retrieve_tracking(tracking_id)
    auth = { username: ENV['WOO_CONSUMER_KEY'], password: ENV['WOO_CONSUMER_SECRET'] }
    headers = { 'Content-Type' => 'application/json' }
    response = self.class.get("/orders/#{@woo_id}/shipment-trackings/#{tracking_id}", basic_auth: auth, headers: headers)
    Rails.logger.info "************* shipping response from woo: #{response} *************************"
  end

  def call
  	auth = { username: ENV['WOO_CONSUMER_KEY'], password: ENV['WOO_CONSUMER_SECRET'] }
  	data = {
  		tracking_provider: @params['carrier'],
  		tracking_number: @params['tracking'],
  		tracking_link: @params['url']
  	}.to_json
  	headers = { 'Content-Type' => 'application/json' }
    response = self.class.post("/orders/#{@woo_id}/shipment-trackings", basic_auth: auth, body: data, headers: headers)
    Rails.logger.info "************* shipping response from woo: #{response} *************************"
    return response
  end

  
end