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

    #remove last from db
  end

  #get price rule
  # ShopifyAPI::PriceRule.find(2897674116)
end


# <script src="{{ 'http://sawyermerchant.pagekite.me/api/v1/discounts' }}" ></script>
