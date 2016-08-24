require 'rails_helper'

RSpec.feature "Org admin can add admin to their organization " do
  scenario "org admin logs in and adds a new admin" do

    org_role = Role.create(name: 'org_admin')
    reg_role = Role.create(name: 'registered_user')
    reg_user = User.create(username: "bill@example.com", password: "password")
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    user.roles << org_role
    user.roles << reg_role
    reg_user.roles << reg_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit organization_dashboard_path(organization_slug: user.organization.slug)

    click_link "Manage Admins"

    expect(current_path).to eq "/admin/homes-for-humanity/users"
    expect(page).to have_content("Admins in your Organization")

    click_link "Add Admin"

    fill_in "Username", with: "bill@example.com"

    click_button "Add Admin"

    expect(current_path).to eq "/admin/homes-for-humanity/users"

    expect(page).to have_content("Admins in your Organization")
    expect(page).to have_content("You've added bill@example.com as an admin")
    expect(page).to have_content("bill@example.com")

  end
end
