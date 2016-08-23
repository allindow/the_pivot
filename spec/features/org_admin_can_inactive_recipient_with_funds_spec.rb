require 'rails_helper'

RSpec.feature "Org admin can inactive recipient with funds" do
  scenario "Org admin changes a recipient with fundings to inactive" do
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role
    country = Country.create(name:"Ghana")
    recipient = organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob", amount_received: 20)

    visit login_path
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "My Organization"
    click_link "Manage Recipients"

    expect(page).to have_content("Deactivate")

    click_link "Deactivate"

    visit recipients_path

    expect(page).to_not have_content("Bob")
    expect(page).to_not have_content("Loves building huts")
  end
end
