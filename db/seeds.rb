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

materials = ["paper, brick, hardcove", "paper stocks, glossym ", "lace, slate, sand", "lace, man-made fibres"]
dimensions = [{H: 5.5, W: 4.3, D: 0.1}, {H: 1.1, W: 7.3, D: 2.9}, {H: 4.7, W: 8.7, D: 0.9}, {H: 2.4, W: 1.3, D: 0.6}]
Category.find_each(start: 2) do |category|
  rand(25..40).times do |n|
    book = Book.create(title: FFaker::Book.title, price: rand(1..99),
      quantity: rand(0..100), description: FFaker::HealthcareIpsum.paragraph, year: rand(1000..2017),
      materials: materials[rand(0..3)], dimensions: dimensions[rand(0..3)])
    rand(1..3).times do |n|
      author = Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)
      book.authors << author
    end
    Category.find_by_title("All books").books << book
    category.books << book
  end
end