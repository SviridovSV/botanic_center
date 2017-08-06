class SortBooksService
  DEFAULT_SORT = :title_asc

  def initialize(params, category = nil)
    @sort_type = params[:sort_type]
    @category = category
  end

  def sort_books
    return Book.send(choose_sort) if @category.nil?
    @category.books.send(choose_sort)
  end

  def choose_title
    Book::SORT_TITLES[choose_sort.to_sym]
  end

  private

  def choose_sort
    @sort_type || DEFAULT_SORT
  end
end