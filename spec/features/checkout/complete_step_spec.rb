require 'rails_helper'

feature 'Confirm step' do
  let!(:address) { create(:address, address_type: 'both') }
  let!(:book) { create(:book) }
  let!(:order_item) { create(:order_item, book: book) }

  background do
    @user = create(:user)
    login_as(@user, scope: :user)
    @order = create(:order, order_items: [order_item], addresses: [address], user: @user)
    allow_any_instance_of(CheckoutsController).to receive(:current_order).and_return(@order)
    visit checkouts_path(id: :complete, done: true)
  end

  scenario 'show complete order info' do
    expect(page).to have_content('Thank You for your Order!')
    expect(page).to have_content("An order confirmation has been sent to #{@user.email}")

    expect(page).to have_content(address.first_name + " " + address.last_name)
    expect(page).to have_content(address.address_name)
    expect(page).to have_content(address.city)
    expect(page).to have_content(address.phone)
    expect(page).to have_content(address.country)

    expect(page).to have_content(book.title)
    expect(page).to have_content("€#{book.price}")
    expect(page).to have_content(book.description.slice(0, 137))

    expect(page).to have_content(@order.created_at.strftime('%m/%d/%Y'))
    expect(page).to have_content("Order ##{@order.track_number}")
  end

  scenario 'redirect to catalog' do
    category = create(:category)
    click_link('Go to Shop')
    expect(current_path).to eq(category_path(category.id))
  end
end
