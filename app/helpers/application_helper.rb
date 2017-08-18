module ApplicationHelper
  def categories_list
    Category.all
  end

  def items_in_cart
    current_order.order_items.size
  end

  def change_class(key)
    case key
    when 'notice' then "success"
    when 'alert' then "danger"
    else key
    end
  end
end
