class UpdateWooShippingService
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
    response = HTTParty.get("https://www.indigosleep.com/wp-json/wc/v1/orders/#{@woo_id}/shipment-trackings/#{tracking_id}", basic_auth: auth, headers: headers)
    Rails.logger.info "************* shipping response from woo: #{response} *************************"
    return response
  end

  def get_list
    auth = { username: ENV['WOO_CONSUMER_KEY'], password: ENV['WOO_CONSUMER_SECRET'] }
    headers = { 'Content-Type' => 'application/json' }
    response = self.class.get("/orders/#{@woo_id}/shipment-trackings", basic_auth: auth, headers: headers)
    return response
  end

  def call
  	auth = { username: ENV['WOO_CONSUMER_KEY'], password: ENV['WOO_CONSUMER_SECRET'] }
    if @params['tracking'].kind_of?(Array)
      tracking_number = @params['tracking'].first
    else
      tracking_number = @params['tracking']
    end
    tracking_numbers = []
    get_list.parsed_response.map { |order| tracking_numbers << order['tracking_number'] }

    if tracking_numbers.include?(tracking_number)
      return true 
    else
    	data = {
    		tracking_provider: @params['carrier'],
    		tracking_number: tracking_number,
    		tracking_link: @params['url'],
        date_shipped: Date.today
    	}.to_json
    	headers = { 'Content-Type' => 'application/json' }
      response = HTTParty.post("https://www.indigosleep.com/wp-json/wc/v1/orders/#{@woo_id}/shipment-trackings", basic_auth: auth, body: data, headers: headers)
      # response = HTTParty.post("https://requestb.in/1d8kawt1", basic_auth: auth, body: data, headers: headers)
      Rails.logger.info "************* shipping response from woo: #{response} *************************"
      return response
    end
  end

  
end