require 'rails_helper'

RSpec.feature "GuestUserCanAddToCart", type: :feature do
  scenario "they can select an amount to lend a recipient" do
  organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
  country = Country.create(name:"Ghana")
  organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")


  visit recipients_path
  expect(page).to have_content("Bob")
  expect(page).to have_content("Cart: $0")

  select("20")
  click_button("Lend")
  expect(page).to have_content("Cart: $20")
  expect(page).to have_content("You're helping Bob")
  end
end
