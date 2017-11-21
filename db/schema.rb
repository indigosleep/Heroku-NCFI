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

ActiveRecord::Schema.define(version: 20171018090136) do

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

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "discounts", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint   "shopifyID"
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

  create_table "woo_acknowledgements", force: :cascade do |t|
    t.integer  "woo_order_id"
    t.bigint   "barnhardt_order_number"
    t.string   "barnhardt_status"
    t.text     "barnhardt_errors"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["woo_order_id"], name: "index_woo_acknowledgements_on_woo_order_id", using: :btree
  end

  create_table "woo_line_items", force: :cascade do |t|
    t.bigint   "wooID"
    t.string   "name"
    t.bigint   "product_id"
    t.bigint   "variation_id"
    t.integer  "quantity"
    t.string   "tax_class"
    t.float    "subtotal"
    t.float    "subtotal_tax"
    t.float    "total"
    t.float    "total_tax"
    t.jsonb    "taxes"
    t.jsonb    "meta_data"
    t.string   "sku"
    t.integer  "price"
    t.integer  "woo_order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["meta_data"], name: "index_woo_line_items_on_meta_data", using: :gin
    t.index ["taxes"], name: "index_woo_line_items_on_taxes", using: :gin
    t.index ["woo_order_id"], name: "index_woo_line_items_on_woo_order_id", using: :btree
  end

  create_table "woo_orders", force: :cascade do |t|
    t.bigint   "wooID"
    t.bigint   "number"
    t.bigint   "parent_id"
    t.string   "order_key"
    t.string   "created_via"
    t.string   "version"
    t.string   "status"
    t.string   "currency"
    t.datetime "date_created"
    t.datetime "date_created_gmt"
    t.datetime "date_modified"
    t.datetime "date_modified_gmt"
    t.float    "discount_total"
    t.float    "discount_tax"
    t.float    "shipping_total"
    t.float    "shipping_tax"
    t.float    "cart_tax"
    t.float    "total"
    t.float    "total_tax"
    t.boolean  "prices_include_tax"
    t.bigint   "customer_id"
    t.string   "customer_ip_address"
    t.text     "customer_user_agent"
    t.text     "customer_note"
    t.jsonb    "billing"
    t.jsonb    "shipping"
    t.string   "payment_method"
    t.string   "payment_method_title"
    t.string   "transaction_id"
    t.datetime "date_paid"
    t.datetime "date_paid_gmt"
    t.datetime "date_completed"
    t.datetime "date_completed_gmt"
    t.text     "cart_hash"
    t.jsonb    "meta_data"
    t.jsonb    "line_items"
    t.jsonb    "tax_lines"
    t.jsonb    "shipping_lines"
    t.jsonb    "fee_lines"
    t.jsonb    "coupon_lines"
    t.jsonb    "refunds"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "phone"
    t.string   "email"
    t.jsonb    "barnhardt_reply"
    t.index ["barnhardt_reply"], name: "index_woo_orders_on_barnhardt_reply", using: :gin
    t.index ["billing"], name: "index_woo_orders_on_billing", using: :gin
    t.index ["coupon_lines"], name: "index_woo_orders_on_coupon_lines", using: :gin
    t.index ["fee_lines"], name: "index_woo_orders_on_fee_lines", using: :gin
    t.index ["line_items"], name: "index_woo_orders_on_line_items", using: :gin
    t.index ["meta_data"], name: "index_woo_orders_on_meta_data", using: :gin
    t.index ["refunds"], name: "index_woo_orders_on_refunds", using: :gin
    t.index ["shipping"], name: "index_woo_orders_on_shipping", using: :gin
    t.index ["shipping_lines"], name: "index_woo_orders_on_shipping_lines", using: :gin
    t.index ["tax_lines"], name: "index_woo_orders_on_tax_lines", using: :gin
  end

  create_table "woo_shipnotices", force: :cascade do |t|
    t.integer  "woo_order_id"
    t.string   "purchase_order_line"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.jsonb    "barnhardt_tracking",  default: {}
    t.index ["barnhardt_tracking"], name: "index_woo_shipnotices_on_barnhardt_tracking", using: :gin
    t.index ["woo_order_id"], name: "index_woo_shipnotices_on_woo_order_id", using: :btree
  end

  create_table "woo_shipping_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postcode"
    t.string   "country"
    t.integer  "woo_order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["woo_order_id"], name: "index_woo_shipping_addresses_on_woo_order_id", using: :btree
  end

  add_foreign_key "woo_line_items", "woo_orders"
  add_foreign_key "woo_shipping_addresses", "woo_orders"
end
