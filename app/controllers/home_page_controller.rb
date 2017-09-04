class HomePageController < ApplicationController
  def index
    save_location
    @category = Category.current_category(params)
    @latest_books = @category.books.latest.take(3)
    @best_sellers = @category.books.popular.take(4)
  end
end
