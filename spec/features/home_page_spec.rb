require 'rails_helper'

feature 'Home page' do
  background do
    @book = create(:book)
    @category1 = create(:category, title: Category::MAIN_GATEGORY, books: [@book])
    @category2 = create(:category, title: 'Category2', books: [create(:book)])
  end

  scenario 'can change category' do
    visit root_path
    expect(page).to have_content 'Buy now'
    expect(page).to have_content "Get Started with"
    expect(page).to have_content @category2.title

    click_link('Category2', match: :first)
    expect(page).to have_content 'Buy now'
    expect(page).to have_content "Get Started with"
    expect(page).to have_content @category1.title
  end

  scenario 'can open book page' do
    visit root_path
    click_link(@book.title)
    expect(page).to have_content @book.quantity
  end

  scenario 'can add book to cart', js: true do
    visit root_path
    click_button('Buy now')
    wait_for_ajax
    expect(find('.shop-quantity')).to have_content('1')
  end
end
