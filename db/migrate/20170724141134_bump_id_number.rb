class BumpIdNumber < ActiveRecord::Migration[5.0]
  def change
  end
  execute "SELECT setval('orders_id_seq', 2500)"
  execute "SELECT setval('acknowledgements_id_seq', 2500)"
  execute "SELECT setval('line_items_id_seq', 2500)"
  execute "SELECT setval('shipnotices_id_seq', 2500)"
  execute "SELECT setval('shipping_addresses_id_seq', 2500)"


end
