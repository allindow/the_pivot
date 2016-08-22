require 'rails_helper'

RSpec.feature "Organization admin can edit organization name and description" do
  scenario "Org admin can edit org" do
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    visit root_path
    click_link 'Login'
    fill_in 'Username', with: 'fiona@cat.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
    
    click_link 'My Organization'
    click_link 'Manage Organization'
    expect(current_path).to eq("/homes-for-humanity/dashboard")
    expect(page).to have_field("Name", with: "Homes for Humanity")
    expect(page).to have_field("Description", with: "We build homes")
    
    fill_in 'Name', with: 'Huts for Humanity'
    fill_in 'Description', with: 'Small hut, big difference'
    
    click_button 'Save'
    
    expect(page).to have_content("Your organization has been updated")
    expect(current_path).to eq("/huts-for-humanity/dashboard")
    expect(page).to have_field("Name", with: "Huts for Humanity")
    expect(page).to have_field("Description", with: "Small hut, big difference")
  end
end