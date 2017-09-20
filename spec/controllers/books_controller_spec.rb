require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #show' do
    before do
      @book = create(:book)
      get :show, params: { id: @book }
    end

    it 'assigns the requested book to @book' do
      expect(assigns(:book)).to eq @book
    end

    it '@book should be decorated' do
      expect(assigns(:book)).to be_decorated
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end
end
