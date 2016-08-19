require 'rails_helper'

RSpec.feature "Registered user can view account" do
  scenario "registered user logs in and can view account" do
    User.create(username: "angela@example.com", password: "password")

    visit '/login'
    fill_in 'Username', with: 'angela@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link 'My Account'

    expect(current_path).to eq '/dashboard'

    expect(page).to have_content("Your Account")
    expect(page).to have_link("Personal Information")
    expect(page).to have_link("My Orders")
    expect(page).to have_content("Welcome angela@example.com!")
  end
end
