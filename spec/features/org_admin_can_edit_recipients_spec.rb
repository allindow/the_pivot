require 'rails_helper'

RSpec.feature "Organization admin can edit recipients" do
  scenario "they can go to the Edit page for a recipient" do

    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role
    country = Country.create(name:"Ghana")
    recipient = organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    visit login_path
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(current_path).to eq(dashboard_path)

    click_link "My Organization"
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
end
