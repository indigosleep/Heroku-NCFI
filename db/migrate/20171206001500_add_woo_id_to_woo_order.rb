class AddWooIdToWooOrder < ActiveRecord::Migration[5.0]
  def change
  	add_column :woo_orders, :woo_id, :bigint
  	add_index :woo_orders, :woo_id, unique: true
  end
end
