require 'rails_helper'

feature 'Sign up' do
  background { create(:category, title: Category::MAIN_GATEGORY) }
  given(:new_user) { build(:user) }

  scenario 'should add new user' do
    expect {
      visit root_path
      click_link('Sign up', match: :first)
      fill_in 'Enter your email', with: new_user.email
      fill_in 'Password', with: new_user.password
      fill_in 'Confirm Password', with: new_user.password
      click_button 'Sign up'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'My account'
    expect(page).not_to have_content 'Sign up'
    expect(current_path).to eq root_path
  end

  scenario 'invalid data' do
    expect {
      visit new_user_registration_path
      fill_in 'Enter your email', with: new_user.email
      click_button 'Sign up'
    }.not_to change(User, :count)

    expect(page).to have_content "Password can't be blank"
    expect(page).to have_css('div.field_with_errors')
  end
end
