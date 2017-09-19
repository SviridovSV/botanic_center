class Book < ApplicationRecord
  before_save :normalize_materials

  has_and_belongs_to_many :category
  has_and_belongs_to_many :authors
  has_many :reviews, -> { where status: :approved }, dependent: :destroy
  has_many :order_items

  mount_uploader :picture, PictureUploader

  validates :title, :price, :quantity, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :year, numericality: { less_than_or_equal_to: Time.current.year }, allow_blank: true

  scope :latest, -> { order(created_at: :desc) }
  scope :title_asc, -> { order(title: :asc) }
  scope :title_desc, -> { order(title: :desc) }
  scope :low_price, -> { order(price: :asc) }
  scope :high_price, -> { order(price: :desc) }

  SORT_TITLES = {
    latest: 'Newest first',
    title_asc: 'A - Z',
    title_desc: 'Z - A',
    low_price: 'Price: low to high',
    high_price: 'Price: high to low',
    popular: 'Popular first'
    }.freeze

  def self.popular
    joins(:order_items).group('id').order('SUM(order_items.quantity) desc')
  end

  def in_stock?
    quantity > 0
  end

  private

  def normalize_materials
    return unless materials?
    self.materials = materials.downcase.capitalize.gsub(/,(?![ ])/, ', ')
  end
end
