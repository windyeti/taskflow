require 'rails_helper'

feature 'Show project' do
  given!(:statuses) { create_list(:status, 4) }
  given!(:project) { create(:project, description: 'This description project test', status: statuses[1], cost: 10000 ) }

  describe 'Authenticated user can see project' do
    given(:user) { create(:user) }
    background { sign_in(user) }
    scenario do
      visit root_path
      click_on project.title

      expect(page).to have_content 'This description project test'
      expect(page).to have_content "#{statuses[1].name.capitalize}"
      expect(page).to have_content "10000 руб."
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
