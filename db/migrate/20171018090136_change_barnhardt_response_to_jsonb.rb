class ChangeBarnhardtResponseToJsonb < ActiveRecord::Migration[5.0]
  def up
    add_column :woo_shipnotices, :temp, :jsonb, default: {}
    WooShipnotice.all.each do |ws|
      ws.temp = ws.barnhardt_tracking.to_json
      ws.save
    end
    remove_column :woo_shipnotices, :barnhardt_tracking
    rename_column :woo_shipnotices, :temp, :barnhardt_tracking

    add_index :woo_shipnotices, :barnhardt_tracking, using: :gin
  end

  def down
    change_column :woo_shipnotices, :barnhardt_tracking, :text
  end
end
