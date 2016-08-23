require 'rails_helper'

RSpec.feature "Org admin can reactivate recipient" do
  scenario "Org admin reactivates a deactivated recipient" do
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role
    country = Country.create(name:"Ghana")
    recipient = organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob", amount_received: 20, retired: true)

    visit login_path
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "My Organization"
    click_link "Manage Recipients"

    expect(page).to have_content("Bob is inactive")
    expect(page).to have_link("Reactivate")

    expect(page).to have_content("Reactivate")

    click_link "Reactivate"

    expect(page).to have_content("Bob has been reactivated")
    expect(page).to have_link("Deactivate")

    visit recipients_path

    expect(page).to have_content("Bob")
    expect(page).to have_content("Loves building huts")
  end
end
