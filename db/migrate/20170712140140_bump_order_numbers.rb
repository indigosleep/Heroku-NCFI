class BumpOrderNumbers < ActiveRecord::Migration[5.0]
  def change
  end
  execute "SELECT setval('orders_id_seq', 1300)"
end
