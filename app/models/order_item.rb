class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  default_scope { order(created_at: :desc) }

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order_id, :book_id, presence: true

  def total_price
    book_price * quantity
  end
end
