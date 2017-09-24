require 'rails_helper'

feature 'Book' do
  background do
    @book = create(:book, :long_description).decorate
    @user = create(:user)
    visit book_path(@book.id)
  end

  scenario 'show book info' do
    expect(page).to have_content(@book.title)
    expect(page).to have_content("€#{@book.price}")
    expect(page).to have_content("#{@book.quantity} Quantity")
    expect(page).to have_content("#{@book.description.slice(0, 347)}")
    expect(page).to have_content("#{@book.dimensions_list}")
    expect(page).to have_content("#{@book.authors_list}")
  end

  scenario 'can show and hide description', js: true do
    click_link('Read More')
    wait_for_ajax
    expect(page).to have_content("#{@book.description}")
    expect(page).to have_content('Hide')

    click_link('Hide')
    expect(page).not_to have_content("#{@book.description}")
    expect(page).to have_content("#{@book.description.slice(0, 347)}")
    expect(page).to have_content('Read More')
  end

  scenario 'any user can see review' do
    review = create(:review, book: @book, user: @user)

    visit book_path(@book.id)
    expect(page).to have_content(review.content)
    expect(page).to have_content('Reviews (1)')
    expect(page).to have_content("Verified Reviewer #{@user.email}")
    expect(page).to have_content('In order to leave a review Log in')
  end

  context 'manage review' do
    background do
      login_as(@user, scope: :user)
      visit book_path(@book.id)
    end

    scenario 'only signed in users can leave review' do
      expect(page).not_to have_content('In order to leave a review Log in')
      expect(page).to have_field('Title')
      expect(page).to have_field('Review')
      expect(page).to have_button('Post')
    end

    scenario 'create review' do
      expect{
        fill_in 'Title', with: 'Title'
        fill_in 'Review', with: 'Review'
        choose('review_rating_3')
        click_button 'Post'
      }.to change(Review, :count).by(1)
      expect(page).to have_content('Thanks for Review. It will be published as soon as Admin will approve it.')
    end

    scenario 'invalid data' do
      expect{ click_button 'Post' }.not_to change(Review, :count)
      expect(page).to have_content('Review form contains mistakes.')
    end
  end

  scenario 'can add book to cart', js: true do
    expect {
      click_button('Add to Cart')
       wait_for_ajax
    }.to change(Order, :count).by(1)
    expect(find('.shop-quantity')).to have_content('1')
    expect(page).to have_css('#add_button.disabled')
  end
end
