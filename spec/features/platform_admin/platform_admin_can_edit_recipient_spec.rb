# As a logged in platform admin,
# When I am on the homepage, and I click a cause,
# on the cause's show page, I see a pencil which I can click to edit the photo or description of a cause. 
# and I should see links to edit or delete under each recipient. 
# When I click edit under a recipient, I am taken to the Recipient Edit page, 
# and I should see a way to upload a new photo
# and I should see a form to edit the recipient information,
# and when I enter a new recipient name,
# and I click on "Update",
# I should be taken to the cause show page,
# and I should see the new recipient name in the recipient list

require 'rails_helper'

RSpec.feature "Platform admin can click to edit recipient details" do
  scenario "platform admin can edit recipients" do
    org = Organization.create!(name:"Walls for the World", description: "We build walls for neighbors", status: 1)
    rec = org.recipients.create(name: "Fiona", description: "I need more kibble.", image_path: "http://www.google.com" )
    
    platform_admin = User.create!(username: "ollie@bollie.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role
  
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(platform_admin)
    
    visit login_path

    fill_in 'Username', with: 'ollie@bollie.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
    
    visit platform_dashboard_index_path
    
    click_link "Manage Recipients"
    expect(org.recipients.first.name).to eq("Fiona")
    save_and_open_page
    expect(page).to have_content("Edit Fiona's profile")
    click_link "Edit Fiona's profile"
    
    fill_in 'Name', with: 'Hungry Hippo'
    fill_in 'Description', with: 'I need food to eat, please.'
    fill_in 'Image Path', with: 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Hippo_Indigestion.jpg'
    click_button 'Update'
    
    
    # 
    # click_link "Manage Recipients"
    expect(current_path).to eq(platform_organizations_path)
    
    visit dashboard_path
    
    click_link "Walls for the World"
    expect(page).to have_content('Hungry Hippo')
    expect(page).to have_content('I need food to eat, please.')
    expect(page).to have_css(:img)
    
  end  
end