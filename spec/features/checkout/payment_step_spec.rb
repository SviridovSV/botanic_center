require 'rails_helper'

feature 'Payment step' do
  background do
    @user = create(:user)
    login_as(@user, scope: :user)
    @order = create(:order, order_items: [create(:order_item)])
    allow_any_instance_of(CheckoutsController).to receive(:current_order).and_return(@order)
    visit checkouts_path(id: :payment, done: true)
  end

  scenario 'show all fields' do
    expect(page).to have_field('Card Number')
    expect(page).to have_field('Name on Card')
    expect(page).to have_field('MM / YY')
    expect(page).to have_field('CVV')
  end

  scenario 'show mistakes' do
    fill_in 'Card Number', with: '12345'
    fill_in 'Name on Card', with: '123'
    fill_in 'MM / YY', with: '11/2'
    fill_in 'CVV', with: 'qwe'
    click_button('Save and Continue')

    expect(page).to have_content('is too short (minimum is 10 characters)')
    expect(page).to have_content('only allows letters')
    expect(page).to have_content('the expiration date must be MM/YY')
    expect(page).to have_content('only allows digits')
    expect(page).to have_css('div.has-error')
  end

  scenario 'saves previos values' do
    fill_in 'Card Number', with: '1234123412341234'
    fill_in 'Name on Card', with: 'Ivanisimo'
    fill_in 'MM / YY', with: '11/22'

    click_button('Save and Continue')

    expect(page).to have_field('Card Number', with: '1234123412341234')
    expect(page).to have_field('MM / YY', with: '11/22')
    expect(page).to have_field('Name on Card', with: 'Ivanisimo')
    expect(page).to have_content("can't be blank")
    expect(page).to have_css('div.has-error')
  end

  scenario 'saves valid data' do
    fill_in 'Card Number', with: '1234123412341234'
    fill_in 'Name on Card', with: 'Ivanisimo'
    fill_in 'MM / YY', with: '11/22'
    fill_in 'CVV', with: '123'

    expect {
      click_button('Save and Continue')
    }.to change(CreditCard, :count).by(1)
  end
end
