require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:orders) }
  end

  describe '#get_address' do
    let(:shipping) { build(:address, address_type: 'shipping') }
    let(:billing) { build(:address, address_type: 'billing') }

    context 'when type is shipping' do
      it 'Return shipping address' do
        user = User.new(addresses: [shipping])
        expect(user.get_address('shipping')).to eq(shipping)
      end
    end

    context 'when type is billing' do
      it 'Return billing address' do
        user = User.new(addresses: [billing])
        expect(user.get_address('billing')).to eq(billing)
      end
    end
  end
end
