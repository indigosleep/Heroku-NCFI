class Make < ActiveRecord::Migration[5.0]
  def change

    change_column :line_items, :variant_id, :string
    change_column :line_items, :sku, :string
    change_column :line_items, :pre_tax_price, :string
    change_column :line_items, :total_discount, :string
    
  end
end
