class SortOrdersService
  DEFAULT_SORT = :all

  def initialize(sort_type, user = nil)
    @sort_type = sort_type
    @user = user
  end

  def sort_orders
    @user.orders.send(choose_sort)
  end

  def choose_title
    Order::SORT_TITLES[choose_sort.to_sym]
  end

  private

  def choose_sort
    @sort_type || DEFAULT_SORT
  end
end