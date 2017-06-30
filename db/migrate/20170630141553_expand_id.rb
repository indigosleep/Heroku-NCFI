class ExpandId < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :id, :integer, limit: 8
  end
end
