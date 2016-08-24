require 'rails_helper'

RSpec.feature "Registered user can create an organization" do
  scenario 'they submit an application for a new cause' do
    user = User.create!(username: 'omar@gmail.com', password: 'password')
    role = Role.create!(name: "registered_user")
    user.roles << role

    expect(User.last.roles.pluck(:name)).to include("registered_user")
    expect(User.last.roles.pluck(:name)).to_not include("platform_admin")
    expect(User.last.roles.pluck(:name)).to_not include("org_admin")

    visit login_path

    fill_in 'Username', with: 'omar@gmail.com'
    fill_in 'Password', with: 'password'
    click_button "Login"

    click_link("Register Organization")

    expect(current_path).to eq(new_organization_path)
    expect(page).to have_content("We invite you to register your cause here. We will review your application and be in touch soon.")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")

    fill_in "Name", with: 'Save the Cats'
    fill_in "Description", with: 'We protect cats and their humans.'
    click_button ("Submit Organization Application")

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Status: Pending")
    expect(page).to_not have_content("Manage Team")
  end
end
