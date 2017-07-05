class AddShopifyIDtoOrderAndLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shopifyID, :integer, limit: 8
    add_column :line_items, :shopifyID, :integer, limit: 8
  end
end
