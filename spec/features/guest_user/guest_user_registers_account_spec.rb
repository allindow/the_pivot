require 'rails_helper'

RSpec.feature "Guest User Registers Account" do
  scenario "they register a new account" do
    visit login_path

    expect(page).to have_field("Username")
    expect(page).to have_field("Password")
    expect(page).to have_content("Want us to host your organization? Click here")

    click_link "Become a Lender"
    expect(current_path).to eq new_user_path
    fill_in 'Username', with: 'angela@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Create Account'

    expect(current_path).to eq '/dashboard'
    expect(page).to have_link 'Logout'
    expect(page).to_not have_link 'Login'
    expect(page).to have_content 'Welcome angela@example.com!'
    expect(page).to have_link 'My Account'
  end
end
