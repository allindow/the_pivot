require 'rails_helper'

RSpec.feature "Platform admin can change status of orgs" do
  scenario 'they can activate a pending org' do
    reg_role = Role.create!(name: 'registered_user')
    Role.create!(name: 'org_admin')
    org = Organization.create!(name:"Hovels for Humanity", description: "We build junky homes", status: 0)
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
    expect(page).to have_button("Activate")
    expect(page).to have_button("Deny")
    expect(page).to_not have_content("Deactivate")

    click_button("Activate")

    expect(page).to have_content("Active")
    expect(page).to have_button("Deactivate")
    expect(page).to_not have_content("Pending")

    expect(reg_user.roles.pluck(:name)).to include("org_admin")

    visit organization_path(slug: org.slug)

    expect(page).to have_content("Hovels for Humanity")
  end

  scenario "platform admin can deny an organization" do
    reg_role = Role.create!(name: 'registered_user')
    org = Organization.create!(name:"Cats for Humanity", description: "We share cats", status: 0)
    reg_user = org.users.create(username: 'cat@example.com', password: 'password')
    reg_user.roles << reg_role

    platform_admin = User.create!(username: "plat@example.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    visit login_path

    fill_in 'Username', with: 'plat@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "Manage Organizations"

    expect(page).to have_content("Cats for Humanity")
    expect(page).to have_content("Pending")
    expect(page).to have_button("Activate")
    expect(page).to have_button("Deny")
    expect(page).to_not have_content("Deactivate")

    click_button("Deny")

    expect(page).to have_content("Denied")
    expect(page).to_not have_button("Activate")
    expect(page).to_not have_content("Pending")

    expect(reg_user.roles.pluck(:name)).to_not include("org_admin")

    visit organization_path(slug: org.slug)

    expect(page).to have_content("Can't find what you're looking for")
  end

  scenario "platform admin can deactivate an active organization" do
    reg_role = Role.create!(name: 'registered_user')
    org_admin_role = Role.create!(name: 'org_admin')
    org = Organization.create!(name:"Dogs for Humanity", description: "We eat dogs", status: 1)
    reg_user = org.users.create(username: 'dog@example.com', password: 'password')
    reg_user.roles << reg_role
    reg_user.roles << org_admin_role

    platform_admin = User.create!(username: "plat@example.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    visit login_path

    fill_in 'Username', with: 'plat@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    click_link "Manage Organizations"

    expect(page).to have_content("Dogs for Humanity")
    expect(page).to have_content("Active")
    expect(page).to have_button("Deactivate")
    expect(page).to_not have_button("Deny")
    expect(page).to_not have_button("Activate")

    click_button("Deactivate")

    expect(page).to have_content("Inactive")
    expect(page).to have_button("Activate")
    expect(page).to_not have_content("Pending")
    expect(page).to_not have_content("Denied")

    expect(reg_user.roles.pluck(:name)).to include("org_admin")

    visit organization_path(slug: org.slug)

    expect(page).to have_content("Can't find what you're looking for")
  end
end
