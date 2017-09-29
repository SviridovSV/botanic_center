require 'rails_helper'

feature 'Confirm step' do
  let!(:address) { create(:address, address_type: 'both') }
  let!(:delivery) { create(:delivery) }
  let!(:credit_card) { create(:credit_card) }
  let!(:book) { create(:book) }
  let!(:order_item) { create(:order_item, book: book) }

  background do
    @user = create(:user)
    login_as(@user, scope: :user)
    @order = create(:order, order_items: [order_item], addresses: [address],
             delivery_id: delivery.id, credit_card_id: credit_card.id)
    allow_any_instance_of(CheckoutsController).to receive(:current_order).and_return(@order)
    visit checkouts_path(id: :confirm, done: true)
  end

  scenario 'show order info' do
    expect(page).to have_content(address.first_name + " " + address.last_name)
    expect(page).to have_content(address.address_name)
    expect(page).to have_content(address.city)
    expect(page).to have_content(address.phone)
    expect(page).to have_content(address.country)

    expect(page).to have_content(delivery.name)
    expect(page).to have_content(credit_card.mm_yy)
    expect(page).to have_content('**** ' * 3 + credit_card.card_number[-4..-1])

    expect(page).to have_content(book.title)
    expect(page).to have_content("€#{book.price}")
    expect(page).to have_content(book.description.slice(0, 137))

    expect(page).to have_content(@order.total_price)
  end

  scenario 'can edit and redirect back' do
    click_link('edit', match: :first)
    expect(current_path).to eq('/checkouts/address')

    click_button('Save and Continue')
    expect(current_path).to eq('/checkouts/confirm')
  end
end
