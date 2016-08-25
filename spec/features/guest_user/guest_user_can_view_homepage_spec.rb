require 'rails_helper'

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
  end
end
