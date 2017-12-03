class WooAcknowledgementsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def update
    @ack = WooAcknowledgement.find_by_id(params[:id])

    respond_to do |format|

      if @ack.update(
        barnhardt_order_number: params[:order_number],
        barnhardt_errors: params[:errors],
        barnhardt_status: params[:status]
      )

        if params[:errors].length > 0
          zt = ZenTicketService.new
          zt.sendBarnhardtError(params)
        end

        format.json { render json: @ack.to_json, status: 201 }
      else

        zt = ZenTicketService.new
        message = "Acknowledgement Error"
        zt.sendError(message, params)

        format.json { render json: @ack.errors.full_messages.to_json, status: 422 }
      end
    end
  end


end
