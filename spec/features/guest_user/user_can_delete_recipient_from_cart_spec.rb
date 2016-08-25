require 'rails_helper'

RSpec.feature "user can delete recipient from cart" do
  scenario "guest user adds recipient to cart and deleted them" do
    organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
    country = Country.create(name:"Ghana")
    organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    visit recipients_path

    select("20")
    click_button("Lend")

    visit cart_path

    expect(page).to have_content("Bob")
    expect(page).to have_content("Total: $20.00")

    click_link "Remove"

    expect(page).to have_content("Total: $0.00")
  end
end
