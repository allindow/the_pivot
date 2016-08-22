require 'rails_helper'

RSpec.feature "Org admin can change recipients in an organization " do
  scenario "org admin deletes a recipient" do

    organization = Organization.create!(name:"Cats for Humanity", description: "We give away cats", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role
    country = Country.create!(name: "USA")
    recipient = organization.recipients.create!(name: "Ollie", description: "need a home", country: country)

    visit root_path
    click_link 'Login'
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "My Organization"
    click_link "Manage Recipients"

    expect(current_path).to eq "/admin/cats-for-humanity/recipients"
    expect(page).to have_content("Name: Ollie")
    expect(page).to have_content("Description: need a home")
    
    expect(page).to have_link("Delete Ollie")
    
    click_link "Delete Ollie"

    expect(current_path).to eq "/admin/cats-for-humanity/recipients"
    expect(page).to_not have_content("Name: Ollie")
    expect(page).to_not have_content("Description: need a home")
  end
end
