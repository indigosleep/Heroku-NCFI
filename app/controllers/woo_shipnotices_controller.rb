require_relative '../../Shopify'
require_relative '../../zenTicket'
class WooShipnoticesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    # byebug
    @shipNote = WooShipnotice.find_by_id(params[:id].to_i)
    @order = WooOrder.find_by_id(params[:purchase_order])
    @line_item = WooLineItem.find_by_id(params[:purchase_order_line])

    respond_to do |format|

      if @shipNote.update(
        purchase_order_line: params[:purchase_order_line],
        barnhardt_tracking: params[:tracking]
      )

        params[:tracking].each do |notice|
          #should just be one
          # s = Shopify.new
          # s.sendShipNotice(@order, notice)
        end

        format.json { render json: @shipNote.to_json, status: 201 }
      else
        zt = ZenTicket.new
        zt.sendShipError(params)

        format.json { render json: @shipNote.errors.full_messages.to_json, status: 422 }
      end
    end
  end
end
