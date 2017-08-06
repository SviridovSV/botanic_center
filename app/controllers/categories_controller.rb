class CategoriesController < ApplicationController
  def show
    @categories = Category.find(params[:id])
    @sorted_books = SortBooksService.new(params, @category).sort_books
  end
end
