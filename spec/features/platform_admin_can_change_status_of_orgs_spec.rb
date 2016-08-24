require 'rails_helper'

RSpec.feature "Platform admin can change status of orgs" do
  scenario 'they can activate a pending org' do
    user = User.create!(username: 'omar@gmail.com', password: 'password')
    role = Role.create!(name: 'registered_user')
    user.roles << role

    visit login_path

    fill_in 'Username', with: 'omar@gmail.com'
    fill_in 'Password', with: 'password'
    click_button "Login"

    click_link("Register Organization")

    fill_in "Name", with: 'Save the Cats'
    fill_in "Description", with: 'We protect cats and their humans.'
    click_button ("Submit Organization Application")

    expect(page).to have_content("Status: Pending")
  end
end
