FactoryGirl.define do
  factory :credit_card do
    card_number '123456789012345'
    name_on_card 'Name'
    mm_yy '11/11'
    cvv '123'
  end
end