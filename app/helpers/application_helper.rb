module ApplicationHelper
  def categories_list
    Category.all
  end

  def change_class(key)
    case key
    when 'notice' then "success"
    when 'alert' then "danger"
    else key
    end
  end
end
