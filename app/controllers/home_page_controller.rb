class HomePageController < ApplicationController
  def index
    @category = Category.current_category(params)
    @latest_books = @category.books.latest.take(3)
  end
end
