class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.integer :year
      t.text :materials
      t.json :dimensions, default: {'H': 0, 'W': 0, 'D': 0}
      t.string :picture

      t.timestamps
    end
  end
end
