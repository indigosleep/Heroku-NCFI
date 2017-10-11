class BumpWooOrderIds < ActiveRecord::Migration[5.0]
  def change
  end
  execute "SELECT setval('woo_orders_id_seq', 3500)"
  execute "SELECT setval('woo_acknowledgements_id_seq', 3500)"
  execute "SELECT setval('woo_line_items_id_seq', 3500)"
  execute "SELECT setval('woo_shipnotices_id_seq', 3500)"
  execute "SELECT setval('woo_shipping_addresses_id_seq', 3500)"
end
