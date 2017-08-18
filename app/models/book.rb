class Book < ApplicationRecord

  before_save { self.materials = materials.downcase.capitalize.gsub(/,(?![ ])/, ', ') }

  has_and_belongs_to_many :category
  has_and_belongs_to_many :authors
  has_many :reviews, -> { where status: :approved }, dependent: :destroy

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

  SORT_TITLES = {:latest => "Newest first", :title_asc => "A - Z", :title_desc => "Z - A",
                 :low_price => "Price: low to high", :high_price => "Price: high to low"}.freeze

  def in_stock?
    quantity > 0
  end
end
