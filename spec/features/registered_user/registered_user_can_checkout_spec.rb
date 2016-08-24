require 'rails_helper'

RSpec.feature "Registered user can checkout" do
  scenario "Guest user becomes registered user after creating account" do
    visit new_user_path
    fill_in 'Username', with: 'angela@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create Account'

    expect(User.last.roles.pluck(:name)).to include("registered_user")
    expect(User.last.roles.pluck(:name)).to_not include("platform_admin")
    expect(User.last.roles.pluck(:name)).to_not include("org_admin")
  end

  scenario "Logged in user adds items to cart and checks out" do
    user = User.create!(username: 'angela@example.com', password: 'password')
    role = Role.create!(name: "registered_user")
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
    expect(page).to have_button("Checkout")

    click_button("Checkout")
    expect(current_path).to eq(funding_path(Funding.last))
    expect(page).to have_content("Total Lent: $20")
    expect(page).to have_content("Bob")
    expect(page).to have_content("Funding created on: ")
    expect(page).to have_content("Funding #{Funding.last.id} Summary")
    expect(page).to have_content("Current status: Awaiting payment")
    expect(page).to have_link("My Fundings")

  end
end
