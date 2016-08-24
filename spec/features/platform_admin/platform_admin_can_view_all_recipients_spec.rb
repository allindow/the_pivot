require 'rails_helper'

RSpec.feature "platform admin can view all recipients" do
  scenario "platform admin clicks Manage Recipients and sees all recipients by organization" do
    create(:recipient)

    platform_admin = User.create!(username: "harry@example.com", password: "password")
    plat_role = Role.create!(name: 'platform_admin')
    platform_admin.roles << plat_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(platform_admin)

    visit platform_dashboard_index_path

    click_link "Manage Recipients"

    expect(page).to have_content(Organization.last.name)
    expect(page).to have_content(Recipient.last.name)
  end
end
