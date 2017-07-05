class RenameProvince < ActiveRecord::Migration[5.0]
  def change
    rename_column :shipping_addresses, :providence, :province
  end
end
