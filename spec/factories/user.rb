FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "TestTest"
    password_confirmation "TestTest"
  end

  trait :admin do
    admin true
  end
end