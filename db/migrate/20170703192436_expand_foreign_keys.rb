class ExpandForeignKeys < ActiveRecord::Migration[5.0]
  def change
    change_column :shipping_addresses, :order_id, :integer, limit: 8
    change_column :line_items, :order_id, :integer, limit: 8
  end
end
