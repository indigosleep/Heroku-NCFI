class ReAddLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|

      t.string   "variant_id"
      t.string   "title"
      t.integer  "quantity"
      t.float    "price"
      t.float    "grams"
      t.string   "sku"
      t.string   "variant_title"
      t.string   "vendor"
      t.string   "fulfillment_service"
      t.bigint   "product_id"
      t.boolean  "requires_shipping"
      t.boolean  "taxable"
      t.boolean  "gift_card"
      t.string   "pre_tax_price"
      t.string   "name"
      t.string   "variant_inventory_management"
      t.text     "properties"
      t.boolean  "product_exists"
      t.integer  "fulfillable_quantity"
      t.string   "total_discount"
      t.string   "fulfillment_status"
      t.text     "tax_lines"
      t.bigint   "shopifyID"

      t.timestamps

    end

    add_reference :line_items, :order, index: true
  end
end
