require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'Associations' do
    it { should have_and_belong_to_many(:books) }
  end
end
