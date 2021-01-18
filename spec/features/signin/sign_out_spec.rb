require 'rails_helper'

feature 'Authenticated user can log out' do
  given(:user) { create(:user) }
  background { sign_in(user) }
  scenario 'Useer can click on button Log out' do
    visit root_path

    within('.header') do
      click_on 'Log out'
    end

    expect(page).to have_content 'Log in'
  end
end
