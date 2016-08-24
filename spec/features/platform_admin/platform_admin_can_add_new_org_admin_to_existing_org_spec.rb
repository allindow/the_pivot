require 'rails_helper'

RSpec.feature "platform admin can add new org admin to existing org" do
  scenario "platform admin logs in and adds a new org admin to org" do
    reg_role = Role.create!(name: 'registered_user')
    Role.create!(name: 'org_admin')
    org = Organization.create!(name:"Hovels for Humanity", description: "We build junky homes", status: 1)
    user = User.create!(username: 'omar@example.com', password: 'password')
    user.roles << reg_role

    platform_admin = User.create!(username: "harry@example.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    visit login_path

    fill_in 'Username', with: 'harry@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "Manage Organizations"

    expect(page).to have_content("Hovels for Humanity")
    expect(page).to have_content("Active")
    expect(page).to have_link("Add Admin")

    click_link "Add Admin"

    expect(current_path).to eq new_platform_organization_user_path

    fill_in "Username", with: 'omar@example.com'
    click_button "Add Admin"

    expect(current_path).to eq platform_organizations_path

    expect(page).to have_content("Hovels for Humanity")
    expect(page).to have_content("omar@example.com")
  end
end
