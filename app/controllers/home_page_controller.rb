class HomePageController < ApplicationController
  def index
    save_location
    @category = Category.home_page_category(params)
    @latest_books = @category.books.latest.decorate.take(3)
    @best_sellers = @category.books.popular.decorate.take(4)
  end
end
