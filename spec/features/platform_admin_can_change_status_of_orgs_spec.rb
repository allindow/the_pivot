require 'rails_helper'

RSpec.feature "Platform admin can change status of orgs" do
  scenario 'they can activate a pending org' do
    reg_role = Role.create!(name: 'registered_user')
    org = Organization.create!(id: 1, name:"Hovels for Humanity", description: "We build junky homes", status: 0)
    reg_user = org.users.create(username: 'omar@example.com', password: 'password')
    reg_user.roles << reg_role

    platform_admin = User.create!(username: "harry@example.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    visit login_path

    fill_in 'Username', with: 'harry@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "Manage Organizations"

    expect(page).to have_content("Hovels for Humanity")
    expect(page).to have_content("Pending")
    expect(page).to have_content("Activate")
    expect(page).to have_content("Deny")
    expect(page).to_not have_content("Deactivate")

    click_button("Activate")

    expect(page).to have_content("Active")
    expect(page).to have_content("Deactivate")
    expect(page).to_not have_content("Pending")

    expect(reg_user.roles.pluck(:name)).to include("org_admin")

    visit organization_path(org)

    expect(page).to have_content("Hovels for Humanity")
  end
end
#
# require 'rails_helper'
#
# RSpec.feature "Org admin has no permissions for denied org" do
#   scenario "they visit org dashboard and see the organization is denied" do
#
#     visit new_user_path
#     fill_in 'Username', with: 'harry@example.com'
#     fill_in 'Password', with: 'password'
#     click_button 'Create Account'
#
#     expect(User.last.roles.pluck(:name)).to include("registered_user")
#
#     click_link "Register Organization"
#     fill_in "Name", with: "Hovels for Humanity"
#     fill_in "Description", with: "We build junky homes"
#
#     click_button "Submit Organization Application"
#
#     # expect(User.last.roles.pluck(:name)).to include("org_admin")
#
#     expect(page).to have_content("Status: Pending")
#
#     # Create a platform_admin with role org_admin
#     # Visit their pending organization path
#     #
#     #
#     #
#
#     # org = Organization.last.update(status: 3)
#     # expect(Organization.last.status).to include("denied")
#     # org_id = Organization.last.id
#     # user = User.last.update(organization_id: org_id)
#     #
#     # visit "/hovels-for-humanity/dashboard"
#     # expect(page).to have_content("Status: Denied")
#     # expect(page).to_not have_content("Name")
#
#   end
#
#   # scenario "they see on the dashboard that the organization has been denied" do
#   #   org = Organization.create!(id: 1, name: "Hovels for Humanity", description: "We build junky homes", status: 3)
#   #   user = User.create(username: "harry@example.com", password: "password", organization_id: 1)
#   #   role = Role.create!(name: "registered_user")
#   #   user.roles << role
#   #
#   #   expect(User.last.roles.pluck(:name)).to include("registered_user")
#   #
#   #   visit "/homes-for-humanity/dashboard"
#   #
#   #   expect(page).to have_content("Status: Denied")
#   # end
# end
#
#   # registered_user = User.create(username: "harry@example.com", password: "password", organization_id: 1)
#
#     # org = Organization.create!(id: 1, name:"Hovels for Humanity", description: "We build junky homes", status: 3)
#     # registered_user = User.create(username: "harry@example.com", password: "password", organization_id: 1)
#     #
#     # expect(User.last.roles.pluck(:name)).to_not include("platform_admin")
#     # expect(User.last.roles.pluck(:name)).to_not include("org_admin")
#     #
#     # visit login_path
#     # fill_in 'Username', with: 'harry@example.com'
#     # fill_in 'Password', with: 'password'
#     # click_button 'Login'
#     #
#     # click_link "My Organization"
#     # expect(page).to have_content("Status: Denied")
#     # expect(page).to_not have_content("Status: Denied")
#
