require 'rails_helper'

RSpec.feature "Organization admin can view their org dashboard" do
  scenario "they can see their organization and link to manage team" do

    organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
    country = Country.create(name:"Ghana")
    user = organization.users.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")
    role = Role.create(name: "org_admin")
    user.roles << role

    visit login_path
    fill_in 'Username', with: 'samson@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content("My Organization")

    click_link "My Organization"
    expect(page).to have_content("Homes of Humanity")
    expect(page).to have_link("Manage Team")
  end
end
