class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.references :books, :category, index: true, foreign_key: true
      t.integer :year
      t.text :materials
      t.text :dimensions

      t.timestamps
    end
  end
end