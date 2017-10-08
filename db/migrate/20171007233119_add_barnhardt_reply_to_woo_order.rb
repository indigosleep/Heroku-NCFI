class AddBarnhardtReplyToWooOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :woo_orders, :barnhardt_reply, :jsonb
    add_index :woo_orders, :barnhardt_reply, using: :gin
  end
end
