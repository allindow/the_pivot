require 'rails_helper'

RSpec.feature "Registered user can login" do
  scenario "they can log in successfully and see a welcome message" do
    user = User.create!(username: 'omar@gmail.com', password: 'password')
    role = Role.create!(name: "registered_user")
    user.roles << role

    expect(User.last.roles.pluck(:name)).to include("registered_user")
    expect(User.last.roles.pluck(:name)).to_not include("platform_admin")
    expect(User.last.roles.pluck(:name)).to_not include("org_admin")

    visit root_path
    click_link "Login"

    expect(current_path).to eq login_path

    fill_in 'Username', with: 'omar@gmail.com'
    fill_in 'Password', with: 'password'
    click_button "Login"

    expect(page).to have_content("Welcome omar")
    expect(page).to have_content("Logged in as omar")
  end

  scenario "the are redirected to their dashboard after logging in" do
    user = User.create!(username: 'omar@gmail.com', password: 'password')
    role = Role.create!(name: "registered_user")
    user.roles << role

    visit recipients_path

    click_link "Login"

    expect(current_path).to eq login_path

    fill_in 'Username', with: 'omar@gmail.com'
    fill_in 'Password', with: 'password'
    click_button "Login"

    expect(current_path).to eq(dashboard_path)
  end
end
