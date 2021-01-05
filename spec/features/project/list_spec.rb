require 'rails_helper'

feature 'Show list of project' do
  given!(:projects) { create_list(:project, 3) }

  describe 'Authenticated' do
    given!(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'user can see list of project' do
      visit projects_path
      expect(page.all('.project').size).to eq projects.size
    end
  end

  describe 'Guest' do
    scenario 'can\'t see list of project' do
      visit projects_path
      expect(page.all('.project').size).to eq 0
    end
  end
end
