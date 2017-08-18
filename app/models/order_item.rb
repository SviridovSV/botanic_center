class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  default_scope { order(created_at: :desc) }

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order_id, :book_id, presence: true
  validate :book_quantity, on: :create
  validate :order_item_uniq, on: :create

  def total_price
    book_price * quantity
  end

  private

  def book_quantity
    if book.quantity < quantity
      errors.add(:order_item, "is out of stock")
    end
  end

  def order_item_uniq
    if order.order_items.find_by_book_id(book.id)
      errors.add(:order_item, "is already in a cart")
    end
  end
end
