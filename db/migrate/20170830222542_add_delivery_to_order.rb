class AddDeliveryToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column    :orders, :delivery_id, :integer
    rename_column :orders, :subtotal, :total_price
    add_column    :orders, :status, :string
    add_column    :orders, :credit_card_id, :integer, index: true
    add_column    :orders, :user_id, :integer, index: true
  end
end
