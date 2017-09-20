require 'rails_helper'

RSpec.describe Ability, type: :model do
  let(:user) { build(:user) }
  let(:signed_user) { create(:user) }
  let(:signed_user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  context "when user is unsigned" do
    subject(:ability) { Ability.new(user) }

    it { should be_able_to(:read, Book) }
    it { should be_able_to(:read, Category) }
  end

  context "when user is signed" do
    subject(:ability) { Ability.new(signed_user) }

    it { should be_able_to(:create, Review.new) }
    it { should be_able_to(:read, Order.new(user_id: signed_user.id)) }
    it { should be_able_to(:continue_shopping, Order.new(user_id: signed_user.id)) }
  end

  context "when user is admin" do
    subject(:ability) { Ability.new(admin) }

    it { should be_able_to(:manage, :all) }
  end
end