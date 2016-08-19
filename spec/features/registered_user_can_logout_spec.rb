require 'rails_helper'

RSpec.feature "Registered user can logout" do
  scenario "when logged in" do
    User.create(username: "angela@example.com", password: "password")

    visit '/login'
    fill_in 'Username', with: 'angela@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(current_path).to eq '/dashboard'
    click_on 'Logout'

    expect(current_path).to eq '/'
    expect(page).to have_content('Successfully logged out')
    expect(page).to_not have_content 'Logout'
  end
end
