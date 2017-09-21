feature 'User orders' do
  background do
    @user = create(:user)
    login_as(@user, scope: :user)
  end

  scenario 'when no orders' do
    visit orders_path
    expect(page).to have_content('You do not have any orders.')
  end

  context 'when user have orders' do
    background do
      @order = create(:order, user: @user, order_items: [create(:order_item)])
      visit orders_path
    end

    scenario 'show order info' do
      expect(page).to have_content('My Orders')
      expect(page).to have_content("Number #{@order.track_number}")
      expect(page).to have_content('In Progress')
      expect(page).to have_content("€#{@order.total_price}")
      expect(page).to have_content @order.created_at.strftime("%Y-%m-%d")

    end

    scenario 'change sort' do
      click_link('Waiting for processing')
      expect(find('a.width-100')).to have_content('Waiting for processing')
      expect(page).not_to have_content("Number #{@order.track_number}")
      expect(page).not_to have_content("€#{@order.total_price}")
      expect(page).not_to have_content @order.created_at.strftime("%Y-%m-%d")
    end

    scenario 'can click order link' do
      click_link(@order.track_number, match: :first)
      expect(page).to have_content("Order #{@order.track_number}")
      expect(page).to have_content("€#{@order.total_price}")
      expect(page).to have_link('Continue shopping')
    end

    scenario 'can continue shopping with coosen order' do
      create(:category, id: 1)
      click_link(@order.track_number, match: :first)
      click_link('Continue shopping')
      expect(find('.shop-quantity', match: :first)).to have_content('1')
    end
  end
end
