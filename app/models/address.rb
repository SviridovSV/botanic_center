class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :first_name, :last_name, :address_name, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address_name, :city, length: { maximum: 50 }
  validates :first_name, :last_name, :city, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :address_name, format: { with: /\A[a-zA-Z0-9\s.,-]+\z/ }
  validates :zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: "only allows numbers" }
  validates :phone, length: { maximum: 15 }, format: { with: /\A^\+[0-9]+\z/, message: "should starts with +" }
end
