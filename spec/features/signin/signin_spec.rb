require 'rails_helper'

feature 'Registered user' do
  given { User.create(email: 'email@mail.ru', password: '123456') }

  scenario 'can sign in with valid data' do
    visit root

    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    expect(page).to have_content 'You are sign in'
  end
  scenario 'cannot sign in with invalid data'
end
