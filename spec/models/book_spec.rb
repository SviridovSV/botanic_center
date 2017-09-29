require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    [:title, :price, :quantity].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
    it do
      should validate_numericality_of(:year)
           .is_less_than_or_equal_to(Time.current.year)
    end
    it { should allow_value(nil).for(:year) }
  end

  describe 'Associations' do
    it { should have_and_belong_to_many(:category) }
    it { should have_and_belong_to_many(:authors) }
    it { should have_many(:reviews).conditions(status: :approved).dependent(:destroy) }
    it { should have_many(:order_items) }
  end

  describe '#in_stock?' do
    it 'return true if quantity > 0' do
      subject.quantity = 1
      expect(subject.in_stock?).to eq(true)
    end
    it 'return false if quantity < 1' do
      subject.quantity = 0
      expect(subject.in_stock?).to eq(false)
    end
  end
end
