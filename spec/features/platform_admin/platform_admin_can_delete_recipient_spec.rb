require 'rails_helper'

RSpec.feature "Platform admin can click to delete recipient" do
  scenario "platform admin can delete recipients" do
    org = Organization.create!(name:"Walls for the World", description: "We build walls for neighbors", status: 1)
    country = Country.create(name:"Germany")
    rec = org.recipients.create(name: "Fiona", description: "I need more kibble.", image_path: "http://www.google.com", country_id: country.id )
    
    platform_admin = User.create!(username: "ollie@bollie.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role
      
    visit login_path

    fill_in 'Username', with: 'ollie@bollie.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
    
    click_link "Manage Recipients"
    
    within("#Fiona") do
      click_link "Delete"
    end
    
    visit '/walls-for-the-world'
    expect(page).to_not have_content('Fiona')
    expect(page).to_not have_content('I need more kibble')
  end  
end