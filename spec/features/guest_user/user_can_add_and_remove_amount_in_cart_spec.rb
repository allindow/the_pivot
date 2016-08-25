require 'rails_helper'

RSpec.feature "user can add and remove amount in cart" do
  scenario "guest user adds recipient to cart and increases and decreases amount" do
    organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
    country = Country.create(name:"Ghana")
    organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    visit recipients_path

    select("20")
    click_button("Lend")

    visit cart_path

    click_link "+"

    expect(page).to have_content("Total: $30.00")

    click_link "-"

    expect(page).to have_content("Total: $20.00")
  end
end
