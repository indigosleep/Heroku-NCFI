class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.integer :variant_id, limit: 8
      t.string :title
      t.integer :quantity
      t.float :price
      t.float :grams
      t.integer :sku
      t.string :variant_title
      t.string :vendor
      t.string :fulfillment_service
      t.integer :product_id, limit: 8
      t.boolean :requires_shipping
      t.boolean :taxable
      t.boolean :gift_card
      t.float :pre_tax_price
      t.string :name
      t.string :variant_inventory_management
      t.text :properties
      t.boolean :product_exists
      t.integer :fulfillable_quantity
      t.float :total_discount
      t.string :fulfillment_status
      t.text :tax_lines
      t.references :order

      t.timestamps
    end
  end
  change_column :orders, :id, :integer, limit: 8
end
