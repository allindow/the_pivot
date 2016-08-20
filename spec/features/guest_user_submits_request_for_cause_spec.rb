require 'rails_helper'

RSpec.feature "Guest user wants to create a new cause" do
  scenario 'they submit an application for a new cause' do
    #do we want this to be a guest user or registered user? 
  visit root_path
  
  click_link("Register Organization")
  
  expect(current_path).to eq(new_organization_path)
  expect(page).to have_content("We invite you to register your cause here. We will review your application and be in touch soon.")
  expect(page).to have_content("Name")
  expect(page).to have_content("Description")
  
  fill_in "Name", with: 'Save the Cats'
  fill_in "Description", with: 'We protect cats and their humans.'
  click_button ("Submit Organization Application")
  
  expect(current_path).to eq( "/save-the-cats/dashboard") 
  expect(page).to have_content("Status: Pending")
  expect(page).to_not have_content("Manage Team")
  end
end
  
  
