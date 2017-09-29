require 'rails_helper'

feature 'Address step' do
  background do
    @user = create(:user)
    login_as(@user, scope: :user)
  end

  scenario 'when cart is empty' do
    visit checkouts_path
    expect(page).to have_content('Cart is empty')
    expect(page).to have_content('You did not add to cart anything.')
  end

  context 'when orders exist' do
    background do
      @order = create(:order, order_items: [create(:order_item)])
      allow_any_instance_of(CheckoutsController).to receive(:current_order).and_return(@order)
    end

    scenario 'have all fields' do
      visit checkouts_path

      expect(page).to have_field('First Name')
      expect(page).to have_field('Last Name')
      expect(page).to have_field('Address')
      expect(page).to have_field('City')
      expect(page).to have_field('Zip')
      expect(page).to have_select('country')
      expect(page).to have_field('Phone')
    end

    scenario 'show mistakes' do
      visit checkouts_path
      within "div#shipping_form" do
        fill_in 'First Name', with: 'Ivan'
        fill_in 'City', with: '123'
        fill_in 'Zip', with: 'qwe'
        fill_in 'Phone', with: '123213123'
      end
      click_button('Save and Continue')

      expect(page).to have_content("can't be blank")
      expect(page).to have_content('only allows letters')
      expect(page).to have_content('only allows numbers')
      expect(page).to have_content('should starts with +')
      expect(page).to have_css('div.has-error')
    end

    scenario 'saves previos values', js: true do
      visit checkouts_path(id: :address)
      find('.checkbox-text').click
      wait_for_ajax

      fill_in 'First Name', with: 'Ivan'
      fill_in 'Last Name', with: 'Banan'
      fill_in 'Address', with: 'Street'
      fill_in 'City', with: 'Dnipro'
      fill_in 'Zip', with: 'qwe'
      fill_in 'Phone', with: '123213123'
      click_button('Save and Continue')

      expect(page).to have_field('First Name', with: 'Ivan')
      expect(page).to have_field('Last Name', with: 'Banan')
      expect(page).to have_field('Address', with: 'Street')
      expect(page).to have_field('City', with: 'Dnipro')
      expect(page).to have_content('only allows numbers')
      expect(page).to have_content('should starts with +')
      expect(page).to have_css('div.has-error')
    end

    scenario 'saves valid data', js: true do
      visit checkouts_path
      find('.checkbox-text').click
      wait_for_ajax

      fill_in 'First Name', with: 'Ivan'
      fill_in 'Last Name', with: 'Banan'
      fill_in 'Address', with: 'Street'
      fill_in 'City', with: 'Dnipro'
      fill_in 'Zip', with: '123'
      fill_in 'Phone', with: '+323213123'

      expect {
        click_button('Save and Continue')
      }.to change(Address, :count).by(1)
      expect(page).to have_content('Shipping:')
    end
  end
end
