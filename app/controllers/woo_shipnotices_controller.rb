require_relative '../../Shopify'
class WooShipnoticesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @shipNote = WooShipnotice.find_by_id(params[:id].to_i)
    @woo_id = @shipNote.woo_order.woo_id
    Rails.logger.info "************ params from NFCI: #{params}******"
    Rails.logger.info "********** tracking class: #{params[:tracking] ? params[:tracking].first.class : 'no params'} ********"
    respond_to do |format|
      if params[:tracking]  && @shipNote.update(
        purchase_order_line: params[:purchase_order_line],
        barnhardt_tracking: params[:tracking].first[:tracking]
      )
        ship_response = UpdateWooShippingService.call(@woo_id, params[:tracking].first)
        order_response = UpdateWooOrderService.call(@woo_id)
        
        @shipNote.woo_order.update(status: 'completed')
        format.json { render json: @shipNote.to_json, status: 200 }
      else
        zt = ZenTicketService.new
        zt.sendShipError(params)

        format.json { render json: @shipNote.errors.full_messages.to_json, status: 422 }
      end
    end
  end
end
