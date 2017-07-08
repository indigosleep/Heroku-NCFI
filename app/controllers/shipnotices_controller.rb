require_relative '../../Shopify'

class ShipnoticesController < ApplicationController
  skip_before_action :verify_authenticity_token


  def update
    # byebug
    @shipNote = Shipnotice.find_by_id(params[:id].to_i)
    @order = Order.find_by_id(params[:purchase_order])
    @line_item = LineItem.find_by_id(params[:purchase_order_line])

    respond_to do |format|

      if @shipNote.update(
        purchase_order_line: params[:purchase_order_line],
        barnhardt_tracking: params[:tracking]
      )

        params[:tracking].each do |notice|
          #should just be one
          s = Shopify.new
          s.sendShipNotice(@order, notice)
        end

        format.json { render json: @shipNote.to_json, status: 201 }
      else
        format.json { render json: @shipNote.errors.full_messages.to_json, status: 422 }
      end
    end
  end
end
