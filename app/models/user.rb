class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :reviews, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    return user if user.get_address('billing')
    user.addresses.create(first_name: auth.info.first_name,
                          last_name: auth.info.last_name,
                          address_type: 'billing')
  end

  def get_address(type)
    addresses.select { |address| address.address_type == type }[0]
  end
end
