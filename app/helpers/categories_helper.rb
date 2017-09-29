module CategoriesHelper
  def sort_title
    SortBooksService.new(params).choose_title
  end
end
