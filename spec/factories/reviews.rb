FactoryGirl.define do
  factory :review do
    book
    content 'Review text'
    title 'title'
    rating 4
    status 'approved'
  end
end
