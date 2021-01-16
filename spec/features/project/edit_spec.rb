require 'rails_helper'

feature 'Author and admin can edit project' do
  describe 'Authenticated Author' do
    given(:user) { create(:user) }
    given!(:project) { create(:project, user: user) }
    background { sign_in(user) }

    scenario 'can edit project with valid data' do
      visit root_path
      within('.project') do
        click_on 'edit'
      end
      expect(page).to have_content 'Edit project'

      fill_in 'Title', with: 'New Title'
      click_on 'Update Project'

      expect(page).to have_content 'New Title'
    end
    scenario 'cannot edit project with invalid data' do
      visit root_path
      within('.project') do
        click_on 'edit'
      end
      expect(page).to have_content 'Edit project'

      fill_in 'Title', with: ''
      click_on 'Update Project'

      expect(page).to have_content 'Edit project'
      expect(page).to have_content "Title can't be blank"
    end
  end
  describe 'Not author' do
    given(:author_user) { create(:user) }
    given(:other_user) { create(:user) }
    given!(:project) { create(:project, user: author_user) }
    background { sign_in(other_user) }

    scenario 'cannot edit project' do
      visit root_path

      expect(page).to_not have_content "edit"
    end
  end
  describe 'Authenticated Admin' do
    scenario 'can edit project with valid data'
    scenario 'cannot edit project with invalid data'
  end
  describe 'Guest' do
    scenario 'cannot edit project'
  end
end
