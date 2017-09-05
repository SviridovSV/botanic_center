class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :first_name, :last_name, :address_name,
            :city, :zip, :country, :phone, presence: true, unless: :user_id?
  validates :first_name, :last_name, :address_name,
            :city, length: { maximum: 50 }
  validates :first_name, :last_name, :city,
            format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }, allow_blank: :user_id?
  validates :address_name, format: { with: /\A[a-zA-Z0-9\s.,-]+\z/ }, allow_blank: :user_id?
  validates :zip, length: { maximum: 10 },
            format: { with: /\A[0-9]+\z/, message: 'only allows numbers' }, allow_blank: :user_id?
  validates :phone, length: { maximum: 15 },
            format: { with: /\A^\+[0-9]+\z/, message: 'should starts with +' }, allow_blank: :user_id?
end
