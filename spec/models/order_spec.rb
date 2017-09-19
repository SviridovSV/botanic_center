require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:delivery) }
    it { should belong_to(:credit_card) }
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:addresses).dependent(:destroy) }
  end

  describe 'States' do
    it 'Default state is In Progress' do
      expect(subject).to have_state(:in_progress)
    end

    it 'After confirm should have state Waiting for processing' do
      subject.confirm
      expect(subject).to have_state(:in_queuen)
    end

    it 'After start delivery should have state In Delivery' do
      subject.confirm
      subject.start_delivery
      expect(subject).to have_state(:in_delivery)
    end

    it 'After finish delivery should have state Delivered' do
      subject.state = :in_delivery
      subject.finish_delivery
      expect(subject).to have_state(:delivered)
    end

    it 'Order can be canceled' do
      expect(subject).to transition_from(:in_delivery, :in_queuen, :in_progress)
                     .to(:canceled).on_event(:cancel)
    end
  end
end
