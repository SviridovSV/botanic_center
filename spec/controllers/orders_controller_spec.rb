require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user, orders: [order]) }
  let(:order) { create(:order) }
  before { sign_in user }

  describe 'GET #index' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
    end

    it 'assigns the requested orders to @orders' do
      expect(assigns(:orders)).to eq user.orders
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order.id } }

    it 'assigns the requested order to @order' do
      expect(assigns(:order)).to eq order
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #continue_shopping' do
    before { get :continue_shopping, params: { id: order.id } }

    it 'assigns the requested order to @order' do
      expect(session[:order_id]).to eq order.id.to_s
    end

    it 'redirects to the category' do
      expect(response).to redirect_to category_path(1)
    end
  end
end
