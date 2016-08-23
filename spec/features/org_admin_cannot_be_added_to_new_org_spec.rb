require 'rails_helper'

RSpec.feature "Org admin cannot be added to a new org" do
  scenario "org admin fails to add an existing org admin" do
    org_role = Role.create(name: 'org_admin')
    reg_role = Role.create(name: 'registered_user')
    reg_user = User.create(username: "bill@example.com", password: "password")
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    user.roles << org_role
    user.roles << reg_role
    reg_user.roles << reg_role
    reg_user.roles << org_role

    visit login_path
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "My Organization"

    click_link "Manage Admins"

    click_link "Add Admin"

    fill_in "Username", with: "bill@example.com"

    click_button "Add Admin"

    expect(current_path).to eq "/admin/#{organization.slug}/users/new"

    expect(page).to have_content("Cannot add user")
  end
end
