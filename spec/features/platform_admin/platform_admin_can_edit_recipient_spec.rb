require 'rails_helper'

RSpec.feature "Platform admin can click to edit recipient details" do
  scenario "platform admin can edit recipients" do
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
    
    click_link "Edit"
    
    expect(org.recipients.first.name).to eq("Fiona")
    expect(page).to have_content("Update")
    
    fill_in 'Name', with: 'Hungry Hippo'
    fill_in 'Description', with: 'I need food to eat, please.'
    fill_in 'Image path', with: 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Hippo_Indigestion.jpg'
    click_button 'Update'
    
    expect(current_path).to eq(platform_recipients_path)
    
    visit dashboard_path
    
    visit '/walls-for-the-world'
    expect(page).to have_content('Hungry Hippo')
    expect(page).to have_content('I need food to eat, please.')
    expect(page).to have_css(:img)
  end  
end