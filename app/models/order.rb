class Order < ApplicationRecord
  include AASM

  before_save { update_total_price }

  has_many :order_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  belongs_to :user
  belongs_to :delivery
  belongs_to :credit_card

  SORT_TITLES = {:all => "All", :in_progress => "In Progress", :in_queuen => "Waiting for processing",
                 :in_delivery => "In Delivery", :delivered => "Delivered"}.freeze

  default_scope { order(created_at: :desc) }
  scope :in_progress, -> { where(state: :in_progress) }
  scope :in_queuen, -> { where(state: :in_queuen) }
  scope :in_delivery, -> { where(state: :in_delivery) }
  scope :delivered, -> { where(state: :delivered) }

  aasm column: 'state', whiny_transitions: false do
    state :in_progress, initial: true
    state :in_queuen, :in_delivery, :delivered, :canceled

    event :confirm do
      transitions :from => :in_progress, :to => :in_queuen
    end

    event :start_delivery do
      transitions :from => :in_queuen, :to => :in_delivery
    end

    event :finish_delivery do
      transitions :from => :in_delivery, :to => :delivered
    end

    event :cancel do
      transitions :from => [:in_queuen, :in_delivery, :delivered, :canceled], :to => :canceled
    end
  end

  def subtotal
    order_items.collect(&:total_price).sum
  end

  def get_address(type)
    if addresses.first.try(:address_type) == 'both'
      return addresses.first
    end
    addresses.select { |address| address.address_type == type }[0]
  end

  def track_number
    'R' + id.to_s
  end

  private

  def update_total_price
    self.total_price = subtotal - (coupon < subtotal ? coupon : 0) + (delivery.nil? ? 0 : delivery.price)
  end
end
