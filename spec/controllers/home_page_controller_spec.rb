require 'rails_helper'

RSpec.describe HomePageController, type: :controller do

  describe "GET #index" do
    before do
      @category = create(:category, title: 'Mobile development')
      get :index
    end

    it 'saves location' do
      expect(session[:forwarding_url]).to eq(request.original_url)
    end

    it 'assigns the requested category to @category' do
      expect(assigns(:category)).to eq @category
    end

    it 'renders the :show template' do
      expect(response).to render_template :index
    end
  end
end
