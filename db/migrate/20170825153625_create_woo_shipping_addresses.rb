class CreateWooShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :woo_shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country
      t.references :woo_order, foreign_key: true

      t.timestamps
    end
  end
end
