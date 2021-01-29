require 'rails_helper'

feature 'User delete project', js: true do
  given(:author_user) { create(:user) }
  given!(:project) { create(:project, user: author_user) }
  context 'Authenticated author' do
    background { sign_in(author_user) }
    scenario 'can delete his project' do
      visit root_path

      accept_alert do
        within '.project' do
          page.find(:css, '.fa-times').click
        end
      end

      expect(page).to_not have_content project.title
    end
  end
  context 'Authenticated not author' do
    given(:other_user) { create(:user) }
    background { sign_in(other_user) }

    scenario 'can delete his project' do
      visit root_path

      within '.project' do
        expect(page).to_not have_content 'delete'
      end
    end
  end
  context 'Admin' do
    given(:admin) { create(:user, role: 'Admin') }
    background { sign_in(admin) }

    scenario 'can delete his project' do
      visit root_path

      accept_alert do
        within '.project' do
          page.find(:css, '.fa-times').click
        end
      end

      expect(page).to_not have_content project.title
    end
  end
  context 'Guest' do
    scenario 'cannot delete project' do
      visit root_path

      expect(page).to_not have_content 'delete'
    end
  end
end
