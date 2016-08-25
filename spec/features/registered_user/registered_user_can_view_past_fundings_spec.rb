require 'rails_helper'

RSpec.feature "Registered user can view past lendings" do
  scenario "Registerd user logs in, adds to cart, checks out, and views funding" do
    user = User.create(username: "angela@example.com", password: "password")
    organization = Organization.create(name:"Homes for Humanity", description: "We build homes", status: 1)
    country = Country.create(name:"Ghana")
    organization.recipients.create(name:"Bob", description:"Loves building huts", country_id: country.id, image_path: "https://robohash.org/Bob")
    role = Role.create(name: 'registered_user')
    user.roles << role

    visit '/login'
    fill_in 'Username', with: 'angela@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link 'All Recipients'
    expect(page).to have_content("Bob")
    expect(page).to have_content("Cart: $0")

    select("20")
    click_button "Lend"
    expect(page).to have_link("Cart: $20")
    expect(page).to have_content("You're helping Bob")
    click_link "Cart: $20"

    expect(page).to have_content("Bob")
    expect(page).to have_content("Total: $20.00")
    expect(page).to have_button("Checkout")

    click_button "Checkout"

    click_link 'My Account'

    expect(current_path).to eq '/dashboard'

    click_link 'My Fundings'

    expect(page).to have_link("Funding #{user.fundings.first.id}")

    click_link "Funding #{user.fundings.first.id}"

    expect(current_path).to eq(funding_path("#{user.fundings.first.id}"))
    expect(page).to have_content("Total Lent: $20")
    expect(page).to have_content("Bob")
    expect(page).to have_content("Funding created on: ")
    expect(page).to have_content("Funding #{user.fundings.first.id} Summary")
    expect(page).to have_content("Current status: Paid")
    expect(page).to have_link("My Fundings")
  end
end
