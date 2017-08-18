class Order < ApplicationRecord
  before_save { self[:subtotal] = subtotal }

  has_many :order_items, dependent: :destroy
  belongs_to :user

  def subtotal
    order_items.collect(&:total_price).sum
  end
end
