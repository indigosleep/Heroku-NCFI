class AddEmailAndPhoneToWooOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :woo_orders, :phone, :string
    add_column :woo_orders, :email, :string
  end
end
