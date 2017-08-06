class CreateJoinTableAuthorBook < ActiveRecord::Migration[5.1]
  def change
    create_join_table :books, :authors do |t|
      t.index [:book_id, :author_id], unique: true
      t.index [:author_id, :book_id]
    end
  end
end
