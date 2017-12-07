
require 'json'
require 'httparty'
class NFCICall
	include HTTParty
	debug_output $stdout
	@headers = {
	      "x-api-key": 'Kb3Jd2LL1o1i2Gk2DwsMz2YOeIV5Zgaw18hqoRZ2',
	      "Content-Type"=> "application/json"
	    }

	@body = {:customer_edi_id=>"402100100554", :purchase_order=>"3547", :purchase_order_revision=>1, :carrier=>"FDX", :required_date=>"2017-12-13T20:34:14Z", :not_before_date=>"2017-12-07T20:34:14+00:00", :note=>"", :order_lines=>[{:purchase_order_line=>"3544", :note=>"", :product_external_id=>"L-MAT-KG-01", :product_id=>"IND-LU-KG", :quantity=>1}], :shipTo=>{:address1=>"4143 State Route 41 NE", :address2=>"", :address3=>"", :city=>"Washington Court Hou", :company=>"", :country=>"US", :email=>"sixzach@yahoo.com", :name=>"Zachary Six", :phone=>"740-335-9992", :postalCode=>"43160", :state=>"OH"}, :notification_urls=>{:order_acknowledgement=>"https://indigosleep.herokuapp.com/api/v1/woo_acknowledgements/3546.json", :ship_notice=>"https://indigosleep.herokuapp.com/api/v1/woo_shipnotices/3546.json"}}.to_json
     
     def self.call
		response = HTTParty.post(
			"https://api.barnhardt.net/v1/order", headers: @headers, body: @body)

		p response
    end
end

NFCICall.call