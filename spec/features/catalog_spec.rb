require 'rails_helper'

feature 'Catalog' do
  background do
    @book = create(:book)
    @category1 = create(:category, title: Category::MAIN_GATEGORY, books: [@book])
    @category2 = create(:category, title: 'Category2')
  end

  scenario 'can add book to cart', js: true do
    visit root_path
    click_link('Shop', match: :first)
    find_button(class: "thumb-hover-link", visible: false).click
    wait_for_ajax
    expect(find('.shop-quantity')).to have_content('1')
  end

  scenario 'change category' do
    visit category_path(@category1.id)
    within('.list-inline', match: :first) do
      find_link(@category2.title).click
    end
    expect(current_path).to eq category_path(@category2.id)
  end

  scenario 'change sort' do
    visit category_path(@category1.id)
    click_link('Newest first', match: :first)
    expect(find("a.width-240")).to have_content('Newest first')
  end

  scenario 'show book info' do
    visit category_path(@category1.id)
    expect(page).to have_content @book.title
    expect(page).to have_content("€#{@book.price}")
  end
end