class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
