require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of (:title) }
  end

  describe 'Associations' do
    it { should have_and_belong_to_many(:books) }
  end

  describe '.home_page_category' do
    let(:params) { Hash.new }
    before do
      @category = Category.create(title: 'test')
      @default_category = Category.create(title: Category::HOME_GATEGORY)
    end

    it 'return category from params' do
      params[:category_id] = @category.id
      expect(Category.home_page_category(params).id).to eq(@category.id)
    end

    it 'return home category if no category in params' do
      expect(Category.home_page_category(params).title).to eq(Category::HOME_GATEGORY)
    end
  end
end
