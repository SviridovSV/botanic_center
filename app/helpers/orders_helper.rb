module OrdersHelper
  def sort_title
    SortOrdersService.new(params[:sort_type]).choose_title
  end

  def order_state_title(sort_type)
    SortOrdersService.new(sort_type).choose_title
  end
end
