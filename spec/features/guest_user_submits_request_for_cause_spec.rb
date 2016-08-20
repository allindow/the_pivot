require 'rails_helper'
# As a guest user,
# when I visit the homepage
# and I click on "Register Organization" 
# I should be taken to the organization registration page
# and I should see a description of the approval process,
# and when I fill in my organization name,
# and I fill in my organization description,
# and I click on Register Organization,
# I should be taken to my organization dashboard,
# and I should see my status as Pending,
# and I should not see Manage Team

RSpec.feature "Guest user wants to create a new cause" do
  scenario 'they submit an application for a new cause' do
  visit root_path
  
  click_link("Register Organization")
  
  expect(current_path).to eq(new_organization_path)
  expect(page).to have_content("We invite you to register your cause here. We will review your application and be in touch soon.")
  expect(page).to have_content("Name")
  expect(page).to have_content("Description")
  
  fill_in "Name", with: 'Save the Cats'
  fill_in "Description", with: 'We protect cats and their humans.'
  click_button ("Submit Organization Application") #need to change waffle card
  
  expect(current_path).to eq(organizations_dashboard_index_path) #not working after this line
  expect(page).to have_content("Status: Pending")
  expect(page).to_not have_content("Manage Team")
  
  end
end
  
  
