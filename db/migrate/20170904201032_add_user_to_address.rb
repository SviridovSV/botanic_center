class AddUserToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :user_id, :integer, index: true
  end
end
