require 'rails_helper'

RSpec.feature "Guest user can adjust cart contents", type: :feature do
  scenario "they can adjust the quantities in the cart" do
    organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
    country = Country.create(name:"Ghana")
    organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    visit recipients_path

    expect(page).to have_content("Bob")
    expect(page).to have_content("Cart: $0")

    select("20")
    click_button("Lend")

    expect(page).to have_content("Cart: $20")

    click_link "Cart: $20"

    expect(page).to have_content("$20.00")

    click_link "+"

    expect(page).to have_content("$30.00")

    click_link "-"

    expect(page).to have_content("$20.00")
  end

  scenario "they can remove recipients from the cart" do
    organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
    country = Country.create(name:"Ghana")
    organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")

    visit recipients_path

    expect(page).to have_content("Bob")
    expect(page).to have_content("Cart: $0")

    select("20")
    click_button("Lend")

    expect(page).to have_content("Cart: $20")

    click_link "Cart: $20"
    
    expect(page).to have_content("Total: $20.00")
    expect(page).to have_content("Bob")
    expect(page).to have_content("Loves building huts")

    click_link "Remove"

    expect(page).to have_content("Successfully removed Bob from your cart.")
    expect(page).to have_content("Total: $0.00")
  end
end
