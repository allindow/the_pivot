require 'rails_helper'

RSpec.feature "Platform admin can see organization details" do
  scenario "they can edit details" do
    org = Organization.create!(name:"Walls for the World", description: "We build walls for neighbors", status: 1)
    platform_admin = User.create!(username: "harry@example.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role
    
    visit login_path

    fill_in 'Username', with: 'harry@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "Manage Organizations"
    
    within("#walls-for-the-world") do
      expect(page).to have_content("Edit")
      click_link "Edit"
    end
    
    fill_in 'Name', with: 'Walls for Friends'
    fill_in 'Description', with: 'We build most excellent walls for friendly neighbors'
    click_button 'Update'
    
    expect(current_path).to eq(platform_organizations_path)
    expect(page).to have_content('Walls for Friends')
    
    click_link('Walls for Friends')
    
    expect(page).to have_content('We build most excellent walls for friendly neighbors')
  end  
end