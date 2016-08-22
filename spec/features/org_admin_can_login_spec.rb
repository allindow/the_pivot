require 'rails_helper'

RSpec.feature "Org admin visits homepage" do
  scenario "org admin can login" do

    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    visit root_path
    click_link 'Login'
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(User.last.roles.pluck(:name)).to include('org_admin')
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_link("Logout")
    expect(page).to have_link("My Organization")
    expect(page).to have_link("My Account")

  end
end
