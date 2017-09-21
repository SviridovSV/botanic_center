require 'rails_helper'

feature 'User settings' do
  background do
    @user = create(:user)
    login_as(@user, scope: :user)
  end

  context 'address tab' do
    background { visit edit_user_registration_path }

    scenario 'show flash messages when valid data' do
      within '#new_address', match: :first do
        fill_in 'First Name', with: 'Max'
        fill_in 'Last Name', with: 'Banan'
        select('USA')
        click_button('Save')
      end

      expect(page).to have_content('Your account has been updated successfully.')

      visit edit_user_registration_path
      expect(page).to have_field('First Name', with: 'Max')
      expect(page).to have_field('Last Name', with: 'Banan')
      expect(page).to have_select('country', selected: 'USA')
    end

    scenario 'show messages when wrong data' do
      within '.col-md-offset-1 form' do
        fill_in 'First Name', with: '123'
        fill_in 'Last Name', with: '1234'
        fill_in 'Zip', with: 'Banan'
        click_button('Save')
      end

      expect(page).to have_field('First Name', with: '123')
      expect(page).to have_field('Last Name', with: '1234')
      expect(page).to have_field('Zip', with: 'Banan')
      expect(page).to have_content('only allows letters')
      expect(page).to have_content('only allows numbers')
      expect(page).to have_css('div.has-error')
    end
  end

  context 'privacy tab' do
    background { visit edit_user_registration_path(tab: :privacy) }

    scenario 'show flash messages when valid data' do
      within '#edit_user', match: :first do
        fill_in 'Enter new email', with: 'maxbanan@gmail.com'
        click_button('Save')
      end

      expect(page).to have_field('Enter new email', with: 'maxbanan@gmail.com')
      expect(page).to have_content('Your account has been updated successfully.')
    end

    scenario 'show messages when wrong data' do
      fill_in 'Old Password', with: '123'
      click_button('Save', class: "mb-10")

      expect(page).to have_content('Current password is invalid')
      expect(page).to have_css('div.has-error')
    end
  end

  scenario 'delete account', js: true do
    visit edit_user_registration_path(tab: :privacy)
    expect(page).to have_button('Remove Account', disabled: true)
    find('.checkbox-text').click
    expect(page).to have_button('Remove Account', disabled: false)
  end
end
