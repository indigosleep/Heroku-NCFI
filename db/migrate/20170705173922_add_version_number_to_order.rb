class AddVersionNumberToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :version, :integer, default: 1
  end
end
