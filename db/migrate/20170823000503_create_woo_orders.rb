class CreateWooOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :woo_orders do |t|
      t.integer :wooID, limit: 8
      t.integer :number, limit: 8
      t.integer :parent_id, limit:8
      t.string :order_key
      t.string :created_via
      t.string :version
      t.string :status
      t.string :currency
      t.datetime :date_created
      t.datetime :date_created_gmt
      t.datetime :date_modified
      t.datetime :date_modified_gmt
      t.float :discount_total
      t.float :discount_tax
      t.float :shipping_total
      t.float :shipping_tax
      t.float :cart_tax
      t.float :total
      t.float :total_tax
      t.boolean :prices_include_tax
      t.integer :customer_id, limit: 8
      t.string :customer_ip_address
      t.text :customer_user_agent
      t.text :customer_note
      t.jsonb :billing
      t.jsonb :shipping
      t.string :payment_method
      t.string :payment_method_title
      t.string :transaction_id
      t.datetime :date_paid
      t.datetime :date_paid_gmt
      t.datetime :date_completed
      t.datetime :date_completed_gmt
      t.text :cart_hash
      t.jsonb :meta_data
      t.jsonb :line_items
      t.jsonb :tax_lines
      t.jsonb :shipping_lines
      t.jsonb :fee_lines
      t.jsonb :coupon_lines
      t.jsonb :refunds

      t.timestamps
    end

    add_index :woo_orders, :billing, using: :gin
    add_index :woo_orders, :shipping, using: :gin
    add_index :woo_orders, :meta_data, using: :gin
    add_index :woo_orders, :line_items, using: :gin
    add_index :woo_orders, :tax_lines, using: :gin
    add_index :woo_orders, :shipping_lines, using: :gin
    add_index :woo_orders, :fee_lines, using: :gin
    add_index :woo_orders, :coupon_lines, using: :gin
    add_index :woo_orders, :refunds, using: :gin



    # add_column :orders, :wooID, :integer, limit: 8
  end
end
