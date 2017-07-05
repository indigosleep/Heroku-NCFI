class RemoveNestedColumnsFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :line_items
    remove_column :orders, :shipping_address
    remove_column :orders, :fulfillments

  end
end
