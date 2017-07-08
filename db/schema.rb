# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170706152103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acknowledgements", force: :cascade do |t|
    t.integer  "order_id"
    t.bigint   "barnhardt_order_number"
    t.string   "barnhardt_status"
    t.text     "barnhardt_errors"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_acknowledgements_on_order_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
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
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "order_id"
    t.index ["order_id"], name: "index_line_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "version",                 default: 1
  end

  create_table "shipnotices", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "purchase_order_line"
    t.text     "barnhardt_tracking"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["order_id"], name: "index_shipnotices_on_order_id", using: :btree
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "address1"
    t.string   "phone"
    t.string   "city"
    t.string   "zip"
    t.string   "province"
    t.string   "country"
    t.string   "last_name"
    t.string   "address2"
    t.string   "company"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "name"
    t.string   "country_code"
    t.string   "province_code"
    t.text     "fulfillments"
    t.text     "refunds"
    t.bigint   "order_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["order_id"], name: "index_shipping_addresses_on_order_id", using: :btree
  end

end
