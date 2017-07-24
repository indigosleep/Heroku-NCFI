class AddShopifyIdToDiscounts < ActiveRecord::Migration[5.0]
  def change
    add_column :discounts, :shopifyID, :integer, limit: 8 
  end
end
