class HomePageController < ApplicationController
  def index
    @category = Category.current_category(params)
    @latest_books = Book.sorted_by(@category).latest.take(3)
  end
end
