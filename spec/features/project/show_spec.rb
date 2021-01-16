require 'rails_helper'

feature 'Show project' do
  given!(:project) { create(:project, description: 'This description project test') }

  describe 'Authenticated user can see project' do
    given(:user) { create(:user) }
    background { sign_in(user) }
    scenario do
      visit root_path
      click_on project.title

      expect(page).to have_content 'This description project test'
    end
  end
  describe 'Guest user cannot see project' do
    scenario do
      visit root_path

      expect(page).to have_content 'Log in'
      expect(page).to_not have_content project.title
    end
  end
end
