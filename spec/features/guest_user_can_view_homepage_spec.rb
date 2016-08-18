require 'rails_helper'

# As a guest user,
# when I visit the homepage,
# I should see the main logo and mission statement,
# I should see a list of the Active Organizations,
# and I should not see any inactive organizations
# and I should not see a link to "My Account"
# and I should see a dropdown of the countries in the side navigation bar
# And I should see "My Cart: 0" in the navigation bar,
# and I should see Login in the navigation bar,
# and I should see a link to Register Organization

RSpec.feature 'Guest user can view homepage' do
  scenario 'they can see the logo and page contents' do
    active_organization = Organization.create!(name: "Homes for Humanity", status: 1)
    inactive_organization = Organization.create!(name: "Diseases for Humanity", status: 2)
    pending_organization = Organization.create!(name: "Drones for Humanity", status: 0)

    visit root_path
    expect(page).to have_content("Lending Hands")
    expect(page).to have_css(:img)
    expect(page).to_not have_content("My Account")
    expect(page).to have_content("Homes for Humanity")
    expect(page).to_not have_content("Drones for Humanity")
    expect(page).to_not have_content("Diseases for Humanity")
    expect(page).to have_content("Cart: $0")
    expect(page).to have_content("Login")
    expect(page).to have_content("Register Organization")
  end
end
