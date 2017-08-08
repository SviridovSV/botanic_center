class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @sorted_books = SortBooksService.new(params, @category).sort_books.page(params[:page])
  end
end
