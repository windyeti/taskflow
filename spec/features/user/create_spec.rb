require 'rails_helper'

feature 'Admin can create new user' do
  context 'Admin' do
    given(:admin) { create(:user, role: 'Admin') }
    background { sign_in(admin) }

    scenario 'can create new user with valid data' do
      visit root_path

      within '.admin_panel' do
        click_on 'Create new user'
      end

      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'

      expect(page).to have_content 'email@email.com'
    end
    scenario 'cannot create new user with invalid data' do
      visit root_path

      within '.admin_panel' do
        click_on 'Create new user'
      end

      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: '123456'

      click_on 'Sign up'

      expect(page).to_not have_content 'email@email.com'
      expect(page).to have_content 'Password confirmation doesn\'t match'
    end
  end
  context 'Authenticated User' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'cannot create new user' do
      visit root_path

      expect(page).to_not have_content 'Create new user'
    end
  end
  context 'Guest' do
    scenario 'cannot create new user' do
      visit root_path

      expect(page).to_not have_content 'Create new user'
      expect(page).to have_selector(:css, '.new_user')
    end
  end
end
