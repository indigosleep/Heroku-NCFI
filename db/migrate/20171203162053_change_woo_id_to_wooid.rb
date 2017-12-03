class ChangeWooIdToWooid < ActiveRecord::Migration[5.0]
  def up
  	rename_column :woo_orders, :wooID, :woo_id
  end

  def down
    rename_column :woo_orders, :woo_id, :wooID
  end
end
