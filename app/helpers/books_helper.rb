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
end
