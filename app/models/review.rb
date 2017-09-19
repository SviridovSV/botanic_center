class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  default_scope { order(created_at: :desc) }

  aasm column: 'status', whiny_transitions: false do
    state :unprocessed, initial: true
    state :approved, :rejected

    event :approve do
      transitions from: :unprocessed, to: :approved
    end

    event :reject do
      transitions from: :unprocessed, to: :rejected
    end

    event :unprocess do
      transitions from: [:rejected, :approved], to: :unprocessed
    end
  end

  validates :user_id, :book_id, :content, :title, :rating, presence: true
  validates :content, length: { maximum: 500 }
  validates :title, length: { maximum: 80 }
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
