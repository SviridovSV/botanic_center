class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :user_id, :book_id, :content, :title, :rating, presence: true
  validates :content, length: { maximum: 500 }
  validates :title, length: { maximum: 80 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def self.default_scope
    order(created_at: :desc)
  end
end
