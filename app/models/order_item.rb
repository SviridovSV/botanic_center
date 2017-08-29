class OrderItem < ApplicationRecord
  after_create :decrease_book_quantity
  after_destroy :increase_book_quantity

  belongs_to :order
  belongs_to :book

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order_id, :book_id, presence: true
  validate :book_quantity, on: :create
  validate :order_item_uniq, on: :create

  default_scope { order(created_at: :desc) }

  def total_price
    book_price * quantity
  end

  private

  def decrease_book_quantity
    book.quantity -= quantity
    book.save
  end

  def increase_book_quantity
    book.quantity += quantity
    book.save
  end

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
