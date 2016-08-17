require 'rails_helper'

# As a guest user,
# when I visit the homepage,
# I should see the main logo and mission statement,
# I should see a list of the Active Organizations,
# and I should not see any inactive organizations
# and I should not see a link to "My Account"
# and I should see a dropdown of the countries in the side navigation bar
# And I should see "My Cart: 0" in the navigation bar,
# and I should see Login in the navigation bar,
# and I should see a link to Register Organization

RSpec.feature 'Guest user can view homepage' do
  scenario 'they can see the logo and page contents' do
    
    visit root_path
    
    expect(page).to have_content("Lending Hand")
    expect(page).to have_css(:img) #this is for the logo
    expect(page).to have_content("Our Mission Statement")
    expect(page).to_not have_content("My Account")
    expect(page).to have_content("Search By Country") 
    expect(page).to have_content("Homes for Humanity") #need to write method for setting status as active or 0? 
    expect(page).to_not have_content("Inactive Organization") #in test I'll write the create methods for these organizations
    # response.body.should have_css("a.dropdown", :text => "Sort by Country")#not sure if this will work 
    expect(page).to have_content("My Cart: 0")
    expect(page).to have_content("Login")
    expect(page).to have_content("Register Organization")
    # find('a.dropdown-toggle').click 
    # click_on 'Manage Users'
  end
end