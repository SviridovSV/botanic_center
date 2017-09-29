require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    before do
      @order = Order.new(order_items: [OrderItem.new])
      allow(controller).to receive(:current_order).and_return(@order)
      get :show
    end

    it 'assigns the current order to @order' do
      expect(assigns(:order)).to eq @order
    end

    it 'assigns the order items to @order_items' do
      expect(assigns(:order_items)).to eq @order.order_items
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'PATCH #update' do
    before do
      @order = Order.new
      @coupon = create(:coupon)
      allow(controller).to receive(:current_order).and_return(@order)
    end

    context 'when coupon exists' do
      before { patch :update, params: { coupon_code: '12345' } }

      it 'locates the requested @coupon' do
        expect(assigns(:coupon)).to eq(@coupon)
      end

      it 'assigns the current order to @order' do
        expect(assigns(:order)).to eq @order
      end

      it 'add coupon to @order' do
        expect(@order.coupon).to eq @coupon.discount
      end

      it 'redirects to the cart with notice' do
        expect(response).to redirect_to cart_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'when coupon does not exists' do
      before { patch :update, params: { coupon_code: "" } }

      it 'will not find coupon' do
        expect(assigns(:coupon)).to eq(nil)
      end

      it 'does not add coupon to @order' do
        expect(@order.coupon).to eq 0
      end

      it 'redirects to the cart with alert' do
        expect(response).to redirect_to cart_path
        expect(flash[:alert]).to be_present
      end
    end
  end
end
