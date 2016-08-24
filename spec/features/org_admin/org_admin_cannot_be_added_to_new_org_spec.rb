require 'rails_helper'

RSpec.feature "Org admin cannot be added to a new org" do
  scenario "org admin fails to add an existing org admin" do
    org_role = Role.create(name: 'org_admin')
    org_user_1 = User.create(username: "bill@example.com", password: "password")
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    org_user_2 = organization.users.create(username: 'fiona@cat.com', password: 'password')
    org_user_1.roles << org_role
    org_user_2.roles << org_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(org_user_2)

    visit organization_dashboard_path(organization_slug: org_user_2.organization.slug)

    click_link "Manage Admins"

    click_link "Add Admin"

    fill_in "Username", with: "bill@example.com"

    click_button "Add Admin"

    expect(current_path).to eq "/admin/#{organization.slug}/users/new"

    expect(page).to have_content("Cannot add user")
  end
end
