class CreateWooLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :woo_line_items do |t|
      t.integer :wooID, limit: 8
      t.string :name
      t.integer :product_id, limit: 8
      t.integer :variation_id, limit: 8
      t.integer :quantity
      t.string :tax_class
      t.float :subtotal
      t.float :subtotal_tax
      t.float :total
      t.float :total_tax
      t.jsonb :taxes
      t.jsonb :meta_data
      t.string :sku
      t.integer :price
      t.references :woo_order, foreign_key: true

      t.timestamps
    end
    add_index :woo_line_items, :taxes, using: :gin
    add_index :woo_line_items, :meta_data, using: :gin

  end
end
