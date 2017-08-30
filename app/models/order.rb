class Order < ApplicationRecord
  before_save { self[:total_price] = subtotal }

  has_many :order_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  belongs_to :user
  belongs_to :delivery
  belongs_to :credit_card

  def subtotal
    order_items.collect(&:total_price).sum
  end

  def get_address(type)
    if addresses.first.try(:address_type) == "both"
      return addresses.first
    end
    addresses.select { |address| address.address_type == type }[0]
  end
end
