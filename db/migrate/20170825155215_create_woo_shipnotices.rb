class CreateWooShipnotices < ActiveRecord::Migration[5.0]
  def change
    create_table :woo_shipnotices do |t|

      t.references :woo_order
      t.string :purchase_order_line
      t.text :barnhardt_tracking

      t.timestamps
    end
  end
end
