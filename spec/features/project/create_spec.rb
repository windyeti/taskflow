require 'rails_helper'

feature 'Create project', js: true do
  context 'Authenticated user' do
    given!(:typejobs) { create_list(:typejob, 5) }
    given!(:status) { create(:status, name: 'start') }
    given!(:statuses) { create_list(:status, 3) }
    given!(:user) { create(:user) }
    background { sign_in(user) }
    scenario 'can create project with valid data' do
      visit root_path
      page.find(:css, '.button_toggle_show_hide_form_create').click

      fill_in 'Title', with: 'Title project'
      check "MyTypejob3"
      click_on 'Create Project'

      expect(page).to have_content 'Title project'

      click_on 'Title project'
      expect(page).to have_content "Start"
    end
    scenario 'cannot create project with invalid data' do
      visit root_path
      page.find(:css, '.button_toggle_show_hide_form_create').click

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
