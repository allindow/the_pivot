require 'rails_helper'

RSpec.feature 'Registered user who has applied for an organization' do
  scenario 'their application is denied' do
    reg_role = Role.create!(name: 'registered_user')
    org = Organization.create!(name:'Hovels for Humanity', description: 'We build junky homes', status: 0)
    reg_user = org.users.create(username: 'omar@example.com', password: 'password')
    reg_user.roles << reg_role

    visit login_path

    fill_in 'Username', with: 'omar@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content('Status: Pending')
    
    org.deny_organization_status

    visit dashboard_path

    expect(page).to have_content('Status: Denied')
    expect(page).to have_content('Please feel free to submit another organization application.')
    expect(page).to have_link('Register Organization')
  end
end
