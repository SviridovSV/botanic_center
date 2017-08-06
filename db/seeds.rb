# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'

Category.create(title: "All books")
Category.create(title: "Mobile development")
Category.create(title: "Photo")
Category.create(title: "Web design")
Category.create(title: "Web development")

Category.find_each(start: 2) do |category|
  rand(7..16).times do |n|
    book = Book.create(title: FFaker::Book.title, price: rand(1..99),
      quantity: rand(50..200), description: FFaker::Book.description)
    rand(1..3).times do |n|
      author = Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)
      book.authors << author
    end
    Category.find_by_title("All books").books << book
    category.books << book
  end
end