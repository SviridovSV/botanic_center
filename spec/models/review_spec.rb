require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Validations' do
    [:user_id, :book_id, :content, :title, :rating].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_length_of(:content).is_at_most(500) }
    it { should validate_length_of(:title).is_at_most(80) }
    it { should validate_numericality_of(:rating).is_greater_than(0) }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'Statuses' do
    it 'Default status is Unprocessed' do
      expect(subject).to have_state(:unprocessed)
    end

    it 'After approve should have status Approved' do
      subject.approve
      expect(subject).to have_state(:approved)
    end

    it 'After reject should have status Rejected' do
      subject.reject
      expect(subject).to have_state(:rejected)
    end

    it 'After unprocess should have status Unprocessed' do
      subject.unprocess
      expect(subject).to have_state(:unprocessed)
    end
  end
end
