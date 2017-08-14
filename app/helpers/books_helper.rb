module BooksHelper
  def book_authors(book)
    authors = []
    book.authors.each do |author|
      authors << "#{author.first_name} #{author.last_name}"
    end
    authors.join(', ')
  end

  def shifting_price_to_currency(book)
    number_to_currency(book.price, unit: '€')
  end

  def book_description(book)
    truncate(book.description, length: 350) {link_to "Read More", "#", class: "in-gold-500 ml-10", id: "read_link"}
  end

  def book_dimensions(book)
    "H: #{book.dimensions[:H]}” x W: #{book.dimensions[:W]}” x D: #{book.dimensions[:D]}”"
  end
end
