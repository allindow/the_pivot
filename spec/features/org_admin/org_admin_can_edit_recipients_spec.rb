require 'rails_helper'

RSpec.feature "Organization admin can edit recipients" do
  scenario "they can go to the Edit page for a recipient" do
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role
    country = Country.create(name:"Ghana")
    recipient = organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit organization_dashboard_path(organization_slug: user.organization.slug)

    click_link "Manage Recipients"

    expect(page).to have_content("Bob")
    expect(page).to have_content("Loves building huts")

    click_link "Edit"

    fill_in "Name", with: "Barb"
    fill_in "Description", with: "Loves building yurts"

    click_button "Save"

    expect(page).to_not have_content("Bob")
    expect(page).to_not have_content("Loves building huts")
    expect(page).to have_content("Barb")
    expect(page).to have_content("Loves building yurts")
  end

  scenario "they try to update a recipient with taken name" do
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role
    country = Country.create(name:"Ghana")

    recipient = organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    organization.recipients.create(name:"Bill", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit organization_dashboard_path(organization_slug: user.organization.slug)

    click_link "Manage Recipients"

    first(:link, "Edit").click

    fill_in "Name", with: ""
    fill_in "Description", with: "Loves building yurts"

    click_button "Save"

    expect(current_path).to eq recipient_path(recipient)
    expect(page).to have_content("Invalid")
  end
end
