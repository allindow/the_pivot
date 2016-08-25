require 'rails_helper'

RSpec.feature 'Platform admin can edit org admin' do
  scenario 'they can update their username and password' do
    org = Organization.create!(name: 'Homes for Humanity', description: 'We build homes', status: 1)
    user = org.users.create(username: 'bob@example.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    platform_admin = User.create!(username: 'harry@example.com', password: 'password')
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    visit login_path
    fill_in 'Username', with: 'harry@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(User.last.roles.pluck(:name)).to include('platform_admin')

    click_link 'Manage Organizations'

    expect(page).to have_content('bob@example.com')
    expect(page).to have_content('Homes for Humanity')
    expect(page).to have_link('Edit')

    click_link 'Edit'

    expect(current_path).to eq(edit_user_path(user.id))
    fill_in 'Username', with: 'sarah@example.com'
    fill_in 'Password', with: 'hello'

    click_button 'Save'
    user.reload
    expect(user.username).to eq('sarah@example.com')
    expect(page).to have_content('sarah@example.com')
    expect(page).to have_content('Homes for Humanity')
  end
end
