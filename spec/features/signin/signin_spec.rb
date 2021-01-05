require 'rails_helper'

feature 'Registered user' do
  given(:user) { create(:user) }

  scenario 'can sign in with valid data' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end
  scenario 'cannot sign in with invalid data' do
    visit new_user_session_path

    click_on 'Log in'

    expect(page).to_not have_content 'Signed in successfully.'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
