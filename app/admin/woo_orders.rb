ActiveAdmin.register WooOrder, as: "Orders" do
  includes :woo_acknowledgements, :woo_line_items, :woo_shipping_addresses, :woo_shipnotices

  # index do
  #
  # end


  show do
    attributes_table do
      row :number
      row :created_via
      row :date_created
      row :total
      row :payment_method
      row :phone
      row :email
      row :barnhardt_reply
    end
    active_admin_comments
  end

end
