class CreateWooAcknowledgements < ActiveRecord::Migration[5.0]
  def change
    create_table :woo_acknowledgements do |t|

      t.references :woo_order
      t.bigint :barnhardt_order_number
      t.string :barnhardt_status
      t.text :barnhardt_errors

      t.timestamps
    end
  end
end
