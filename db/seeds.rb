require 'ffaker'

User.create(email: 'admin@admin.com', password: '12345678', password_confirmation: '12345678', admin: true)

Category.create(title: 'All books')
Category.create(title: 'Mobile development')
Category.create(title: 'Photo')
Category.create(title: 'Web design')
Category.create(title: 'Web development')

Coupon.create(code: '6ghf85', discount: 5)
Coupon.create(code: 'eff77d', discount: 10)

materials = ['paper, brick, hardcove', 'paper stocks, glossym', 'lace, slate, sand', 'lace, man-made fibres']
dimensions = [{ H: 5.5, W: 4.3, D: 0.1 }, { H: 1.1, W: 7.3, D: 2.9 }, { H: 4.7, W: 8.7, D: 0.9 }, { H: 2.4, W: 1.3, D: 0.6 }]
Category.find_each(start: 2) do |category|
  rand(25..40).times do
    book = Book.create(
      title: FFaker::Book.title,
      price: rand(1..99),
      quantity: rand(0..100),
      description: FFaker::HealthcareIpsum.paragraph,
      year: rand(1000..2017),
      materials: materials[rand(0..3)],
      dimensions: dimensions[rand(0..3)]
    )
    rand(1..3).times do
      author = Author.create(
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name
      )
      book.authors << author
    end
    Category.find_by_title('All books').books << book
    category.books << book
  end
end

Delivery.create(name: 'Delivery Next Day!', min_day: 1, max_day: 2, price: 10)
Delivery.create(name: 'Super perevozki', min_day: 4, max_day: 8, price: 5)
Delivery.create(name: 'Pick Up In-Store', min_day: 1, max_day: 10, price: 0)
