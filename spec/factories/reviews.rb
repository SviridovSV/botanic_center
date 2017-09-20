FactoryGirl.define do
  factory :review do
    book
    content 'Review'
    title 'title'
    rating 5
  end
end
