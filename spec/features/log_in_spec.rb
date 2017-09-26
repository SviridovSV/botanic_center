require 'rails_helper'

feature 'Log in' do
  background { create(:category, title: Category::MAIN_GATEGORY) }
  given(:user) { create(:user) }
  given(:admin) { create(:admin) }


  scenario 'log in as persisted user' do
    visit root_path
    click_link('Log in', match: :first)
    fill_in 'Enter your email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'My account'
    expect(page).not_to have_content 'Admin panel'
    expect(page).not_to have_content 'Log in'
    expect(current_path).to eq root_path
  end

  scenario 'log in as admin' do
    visit new_user_session_path
    fill_in 'Enter your email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'My account'
    expect(page).to have_content 'Admin panel'
    expect(page).not_to have_content 'Log in'
  end

  scenario 'invalid data' do
    visit new_user_session_path
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Sign up'
    expect(current_path).to eq new_user_session_path
  end
end
