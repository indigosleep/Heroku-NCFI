require_relative '../../Shopify'
class WooShipnoticesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @shipNote = WooShipnotice.find_by_id(params[:id].to_i)

    respond_to do |format|
      
      if params[:tracking]  && @shipNote.update(
        purchase_order_line: params[:purchase_order_line],
        barnhardt_tracking: params[:tracking]
      )
        UpdateWooOrderService.call(@shipnote.woo_order)
        format.json { render json: @shipNote.to_json, status: 201 }
      else
        zt = ZenTicketService.new
        zt.sendShipError(params)

        format.json { render json: @shipNote.errors.full_messages.to_json, status: 422 }
      end
    end
  end
end
