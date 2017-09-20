require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #show' do
    before do
      @category = create(:category)
      get :show, params: { id: @category }
    end

    it 'saves location' do
      expect(session[:forwarding_url]).to eq(request.original_url)
    end

    it 'assigns the requested category to @category' do
      expect(assigns(:category)).to eq @category
    end

    it 'assigns the requested category books to @sorted_books' do
      expect(assigns(:sorted_books)).to eq @category.books
    end

    it '@sorted_book should be decorated' do
      expect(assigns(:sorted_books)).to be_decorated
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end
end
