require 'rails_helper'

RSpec.feature "org admin cannot register two orgs" do
  scenario "org admin logs in and does not see register org link" do
    org_role = Role.create(name: 'org_admin')
    reg_role = Role.create(name: 'registered_user')
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    user.roles << org_role
    user.roles << reg_role

    visit root_path
    click_link 'Login'
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(current_path).to eq dashboard_path

    expect(page).to_not have_content("Register Organization")
  end
end
