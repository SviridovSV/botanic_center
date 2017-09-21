require 'rails_helper'

feature 'Cart' do
  scenario 'when no current order' do
    visit cart_path
    expect(page).to have_content('You did not add to cart anything.')
  end

  context 'when user have current order' do
    background do
      @order = create(:order, order_items: [create(:order_item)])
      allow_any_instance_of(CartsController).to receive(:current_order).and_return(@order)
      allow_any_instance_of(OrderItemsController).to receive(:current_order).and_return(@order)
      visit cart_path
    end

    scenario 'show order info' do
      expect(page).to have_content("€#{@order.total_price}")
      expect(page).to have_field('Enter Your Coupon Code')
    end

    scenario 'can delete order item' do
      expect {
        find('.general-cart-close', match: :first).click
      }.to change(OrderItem, :count).by(-1)
      expect(page).to have_content('Item deleted.')
    end

    scenario 'show flash messages when change' do
      expect {
        find('.input-link', match: :first).click
      }.to change(@order.reload, :total_price)
      expect(page).to have_content('Item updated.')
    end

    scenario 'activate coupon' do
      coupon = create(:coupon)

      expect{
        fill_in 'Enter Your Coupon Code', with: coupon.code
        click_button('Update cart')
      }.to change(@order.reload, :total_price)
      expect(page).to have_content('Coupon was activated.')
      expect(page).to have_content("€#{coupon.discount}")
    end

    scenario 'wrong coupon code' do
      expect{
        fill_in 'Enter Your Coupon Code', with: 'wrong'
        click_button('Update cart')
      }.not_to change(@order.reload, :total_price)
      expect(page).to have_content('Wrong coupon code.')
      expect(page).to have_content('Coupon: €0.00')
    end

    scenario 'checkout link' do
      click_button('Checkout', match: :first)
      expect(current_path).to eq new_user_session_path
    end
  end
end