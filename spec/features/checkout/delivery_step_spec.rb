require 'rails_helper'

feature 'Delivery step' do
  background do
    @user = create(:user)
    login_as(@user, scope: :user)
    @order = create(:order, order_items: [create(:order_item)])
    @delivery = create(:delivery)
    allow_any_instance_of(CheckoutsController).to receive(:current_order).and_return(@order)
    visit checkouts_path(id: :delivery, done: true)
  end

  scenario 'show delivery info' do
    expect(page).to have_content(@delivery.name)
    expect(page).to have_content("#{@delivery.min_day } to #{@delivery.max_day } days")
    expect(page).to have_content("€#{@delivery.price}")
  end

  scenario 'show flash when do not choose delivery' do
    click_button('Save and Continue')
    expect(page).to have_content('You have to choose delivery.')
  end

  scenario 'save delivery', js: true do
    find('.radio-text', match: :first).click
    click_button('Save and Continue')
    expect(@order.reload.delivery_id).to eq(@delivery.id)
  end
end
