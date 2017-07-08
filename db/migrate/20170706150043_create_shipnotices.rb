class CreateShipnotices < ActiveRecord::Migration[5.0]
  def change
    create_table :shipnotices do |t|
      t.references :order
      t.string :purchase_order_line
      t.text :barnhardt_tracking

      t.timestamps
    end
  end
end
