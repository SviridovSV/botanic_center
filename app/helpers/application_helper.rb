module ApplicationHelper
  def categories_list
    Category.all
  end

  def books_list
    Book.all
  end
end
