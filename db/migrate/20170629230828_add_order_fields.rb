class AddOrderFields < ActiveRecord::Migration[5.0]
  def change
    # add_column :orders, :id, :integer
    add_column :orders, :email, :string
    add_column :orders, :closed_at, :string
    # add_column :orders, :created_at, :string
    # add_column :orders, :updated_at, :string
    add_column :orders, :number, :integer
    add_column :orders, :note, :text
    add_column :orders, :token, :string
    add_column :orders, :gateway, :string
    add_column :orders, :test, :boolean
    add_column :orders, :total_price, :string
    add_column :orders, :subtotal_price, :string
    add_column :orders, :total_weight, :float
    add_column :orders, :total_tax, :string
    add_column :orders, :taxes_included, :boolean
    add_column :orders, :currency, :string
    add_column :orders, :financial_status, :string
    add_column :orders, :confirmed, :boolean
    add_column :orders, :total_discounts, :string
    add_column :orders, :total_line_items_price, :string
    add_column :orders, :cart_token, :string
    add_column :orders, :buyer_accepts_marketing, :boolean
    add_column :orders, :name, :string
    add_column :orders, :referring_site, :string
    add_column :orders, :landing_site, :string
    add_column :orders, :cancelled_at, :string
    add_column :orders, :cancel_reason, :string
    add_column :orders, :total_price_usd, :string
    add_column :orders, :checkout_token, :string
    add_column :orders, :reference, :string
    add_column :orders, :user_id, :integer
    add_column :orders, :location_id, :integer
    add_column :orders, :source_identifier, :string
    add_column :orders, :source_url, :string
    add_column :orders, :processed_at, :string
    add_column :orders, :device_id, :string
    # add_column :orders, :phone, :string
    add_column :orders, :browser_ip, :string
    add_column :orders, :landing_site_ref, :string
    add_column :orders, :order_number, :integer
    add_column :orders, :discount_codes, :text
    add_column :orders, :note_attributes, :text
    add_column :orders, :payment_gateway_names, :text
    add_column :orders, :processing_method, :string
    add_column :orders, :checkout_id, :string
    add_column :orders, :source_name, :string
    add_column :orders, :fulfillment_status, :string
    add_column :orders, :tax_lines, :text
    add_column :orders, :tags, :string
    add_column :orders, :contact_email, :string
    add_column :orders, :order_status_url, :string
    add_column :orders, :line_items, :text
    add_column :orders, :shipping_lines, :text
    add_column :orders, :billing_address, :text
    add_column :orders, :shipping_address, :text
    add_column :orders, :fulfillments, :text
    add_column :orders, :refunds, :text
    add_column :orders, :customer, :text



  end
end
