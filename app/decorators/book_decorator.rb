class BookDecorator < Draper::Decorator
  delegate_all

  def authors_list
    authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def short_description
    h.truncate(description, length: 350) {h.link_to "Read More", "#", class: "in-gold-500 ml-10", id: "read_link"}
  end

  def dimensions_list
    "H: #{dimensions['H']}” x W: #{dimensions['W']}” x D: #{dimensions['D']}”"
  end

  def in_current_order?
    h.current_order.order_items.map { |item| item.book }.include?(object)
  end
end
