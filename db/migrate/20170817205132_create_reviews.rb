class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.integer :rating
      t.string :status
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end

    add_index :reviews, :book_id
  end
end
