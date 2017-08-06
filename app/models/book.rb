class Book < ApplicationRecord
  has_and_belongs_to_many :category
  has_and_belongs_to_many :authors

  validates :title, :price, :quantity, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  scope :latest, -> { order(created_at: :desc) }
  scope :title_asc, -> { order(title: :asc) }
  scope :title_desc, -> { order(title: :desc) }
  scope :low_price, -> { order(price: :asc) }
  scope :high_price, -> { order(price: :desc) }

  SORT_TITLES = {:latest => "Newest first", :title_asc => "A - Z", :title_desc => "Z - A",
                 :low_price => "Price: low to high", :high_price => "Price: high to low"}.freeze
end
