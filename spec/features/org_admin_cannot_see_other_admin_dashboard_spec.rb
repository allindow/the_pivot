require 'rails_helper'

RSpec.feature "Organization admin sees organization dashboard" do
  scenario "organization admin cannot see other organizations dashboard" do
    org_role = Role.create(name: 'org_admin')
    org = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    other_org = Organization.create!(name:"Cardboard Boxes for Homes", description: "We give out recycling", status: 1)
    org_user = org.users.create(username: 'fiona@cat.com', password: 'password')
    org_user.roles << org_role

    visit login_path
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "My Organization"
    
    expect(page).to have_content("Homes for Humanity")
    expect(page).to_not have_content("Cardboard Boxes for Homes")
    
    visit '/cardboard-boxes-for-homes/dashboard'
    expect(page.status_code).to eq(403)
  end
end
