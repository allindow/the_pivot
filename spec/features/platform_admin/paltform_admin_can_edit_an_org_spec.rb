require 'rails_helper'

RSpec.feature 'Platform admin can edit organization details' do
  scenario 'they can update the name, description, and image' do
    platform_admin = User.create!(username: 'harry@example.com', password: 'password')
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    org = Organization.create!(name: 'Homes for Humanity', description: 'We build homes', status: 1)
    user = org.users.create(username: 'bob@example.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    visit login_path
    fill_in 'Username', with: 'harry@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link 'Manage Admins'

    expect(page).to have_content('bob@example.com')
    expect(page).to have_content('Homes for Humanity')
    expect(page).to have_link_or_button('Edit')

    click_link_or_button 'Edit'

    fill_in 'Username', with: 'karen@example.com'

    click_link_or_button 'Save'

    # expect(current_path).to eq(idk)
    expect(page).to have_content('sarah@example.com')
    expect(page).to have_content('Homes for Humanity')
  end
end
