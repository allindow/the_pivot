require 'rails_helper'

RSpec.feature "GuestUserCanViewCart", type: :feature do
  scenario "they can view contents in their cart" do
  organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
  country = Country.create(name:"Ghana")
  organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

  visit recipients_path

  expect(page).to have_content("Bob")
  expect(page).to have_content("Cart: $0")

  select("20")
  click_button("Lend")
  click_link("Cart: $20")

  expect(page).to have_xpath("//img[@src='https://robohash.org/Bob']")
  expect(page).to have_content("Bob")
  expect(page).to have_content("Loves building huts")
  expect(page).to have_content("Total: $20.00")
  expect(page).to have_selector(:link_or_button, "Login to Checkout")
  expect(page).to have_selector(:link_or_button, "Register")
  end
end
