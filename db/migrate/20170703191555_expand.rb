class Expand < ActiveRecord::Migration[5.0]
  def change
    change_column :line_items, :id, :integer, limit: 8
  end
end
