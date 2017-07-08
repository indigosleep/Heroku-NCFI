class CreateAcknowledgements < ActiveRecord::Migration[5.0]
  def change
    create_table :acknowledgements do |t|
      t.references :order
      t.bigint :barnhardt_order_number
      t.string :status
      t.text :errors

      t.timestamps
    end
  end
end
