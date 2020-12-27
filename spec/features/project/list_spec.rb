require 'rails_helper'

feature 'Show list of project' do
  given!(:projects) { create_list(:project, 3) }

  describe 'User see list' do
    scenario '' do
      visit projects_path
      expect(page.all('.project').size).to eq projects.size
    end
  end
end
