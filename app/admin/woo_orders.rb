ActiveAdmin.register WooOrder, as: "Orders" do
  includes :woo_acknowledgements, :woo_line_items, :woo_shipping_addresses, :woo_shipnotices

  index do
    selectable_column
    column "woo_id" do |order|
      link_to order.number, admin_order_path(order)
    end
    column "PO" do |order|
      link_to order.id, admin_order_path(order)
    end
    column "Date", :date_created
    column "Discount", :discount_total, sortable: false
    column :total
    column :status, sortable: false
    column "Method", :payment_method, sortable: false
    # column "Paid on", :date_paid
    # column "Line Items" do |li|
    #   link_to li.id, admin_line_item(li)
    # end
    column "Via", :created_via
    column :phone, sortable: false
    column :email, sortable: false
    column ' Original NFCI Reply', :barnhardt_reply
    column "Shipping" do |order|
      if order.woo_shipnotices.present?
        order.woo_shipnotices.first.barnhardt_tracking
      end
    end

  end


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
