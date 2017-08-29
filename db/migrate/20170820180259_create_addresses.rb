class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :city
      t.string  :zip
      t.string  :phone
      t.string  :address_name
      t.integer :order_id
      t.string  :country
      t.string  :address_type

      t.timestamps
    end
  end
end
