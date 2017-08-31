class AddStateToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :state, :string
    add_column :orders, :coupon, :integer, default: 0
  end
end
