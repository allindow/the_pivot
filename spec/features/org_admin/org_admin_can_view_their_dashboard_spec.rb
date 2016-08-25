require 'rails_helper'

RSpec.feature "Organization admin can view their org dashboard" do
  scenario "they can see their organization and link to manage team" do
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit organization_dashboard_path(organization_slug: user.organization.slug)

    expect(User.last.roles.pluck(:name)).to include('org_admin')
    expect(page).to have_link("My Organization")

    click_link "My Organization"

    expect(page).to have_content("Homes for Humanity")
    expect(page).to have_content("Status: Active")
    expect(page).to have_link("Manage Organization")
    expect(page).to have_link("Manage Recipients")
    expect(page).to have_link("Manage Admins")
  end
end
