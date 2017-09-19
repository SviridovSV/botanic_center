class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    save_location
    @sorted_books = SortBooksService.new(params, @category.books).sort_books
                    .page(params[:page]).decorate
  end
end
