class CreateShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :address1
      t.string :phone
      t.string :city
      t.string :zip
      t.string :providence
      t.string :country
      t.string :last_name
      t.string :address2
      t.string :company
      t.string :latitude
      t.string :longitude
      t.string :name
      t.string :country_code
      t.string :province_code
      t.text :fulfillments
      t.text :refunds
      t.references :order

      t.timestamps
    end
  end
end
