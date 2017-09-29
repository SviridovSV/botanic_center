FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'TestTest'
    password_confirmation 'TestTest'

    factory :admin do
      admin true
    end
  end
end
