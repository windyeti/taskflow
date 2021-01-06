require 'rails_helper'

feature 'Create project', js: true do
  context 'Authenticated user' do
    given!(:user) { create(:user) }
    background { sign_in(user) }
    scenario 'can create project with valid data' do
      visit root_path

      fill_in 'Title', with: 'Title project'
      click_on 'Create Project'

      expect(page).to have_content 'Title project'
    end
    scenario 'cannot create project with invalid data' do
      visit root_path

      click_on 'Create Project'

      expect(page).to have_content 'Title can\'t be blank'
      expect(page).to_not have_content 'Title project'
    end
  end
  context 'Guest cannot create project' do
    scenario 'with valid data' do
      visit root_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
