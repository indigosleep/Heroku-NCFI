class AcknowledgementsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def update
    @ack = Acknowledgement.find_by_id(params[:id])

    respond_to do |format|

      if @ack.update(
        barnhardt_order_number: params[:order_number],
        barnhardt_errors: params[:errors],
        barnhardt_status: params[:status]
      )
        format.json { render json: @ack.to_json, status: 201 }
      else
        format.json { render json: @ack.errors.full_messages.to_json, status: 422 }
      end
    end
  end


end
