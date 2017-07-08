class ReAddOrdersAndLineitems < ActiveRecord::Migration[5.0]
  def change
    drop_table :line_items
    drop_table :orders

    create_table :orders do |t|

      t.string   "email"
      t.string   "closed_at"
      t.integer  "number"
      t.text     "note"
      t.string   "token"
      t.string   "gateway"
      t.boolean  "test"
      t.string   "total_price"
      t.string   "subtotal_price"
      t.float    "total_weight"
      t.string   "total_tax"
      t.boolean  "taxes_included"
      t.string   "currency"
      t.string   "financial_status"
      t.boolean  "confirmed"
      t.string   "total_discounts"
      t.string   "total_line_items_price"
      t.string   "cart_token"
      t.boolean  "buyer_accepts_marketing"
      t.string   "name"
      t.string   "referring_site"
      t.string   "landing_site"
      t.string   "cancelled_at"
      t.string   "cancel_reason"
      t.string   "total_price_usd"
      t.string   "checkout_token"
      t.string   "reference"
      t.integer  "user_id"
      t.integer  "location_id"
      t.string   "source_identifier"
      t.string   "source_url"
      t.string   "processed_at"
      t.string   "device_id"
      t.string   "browser_ip"
      t.string   "landing_site_ref"
      t.integer  "order_number"
      t.text     "discount_codes"
      t.text     "note_attributes"
      t.text     "payment_gateway_names"
      t.string   "processing_method"
      t.string   "checkout_id"
      t.string   "source_name"
      t.string   "fulfillment_status"
      t.text     "tax_lines"
      t.string   "tags"
      t.string   "contact_email"
      t.string   "order_status_url"
      t.text     "shipping_lines"
      t.text     "billing_address"
      t.text     "refunds"
      t.text     "customer"
      t.bigint   "shopifyID"

      t.timestamps
    end



  end
end
