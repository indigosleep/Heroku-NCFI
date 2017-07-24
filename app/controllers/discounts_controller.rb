class DiscountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.js {
        # @discount = nil
        @discountCount = Discount.count
        @discount = Discount.last if @discountCount > 0
      }
    end

  end

end
