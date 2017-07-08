class ChangeColumnNamesInAck < ActiveRecord::Migration[5.0]
  def change
    rename_column :acknowledgements, :status, :barnhardt_status
    rename_column :acknowledgements, :errors, :barnhardt_errors
  end
end
