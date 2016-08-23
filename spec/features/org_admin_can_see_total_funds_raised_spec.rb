require 'rails_helper'

RSpec.feature "Org admin sees funds raised" do
  scenario "on dashboard when logged in" do
    org_role = Role.create(name: 'org_admin')
    recipient = create(:recipient)
    org_user_1 = User.create(username: "bill@example.com", password: "password", organization: recipient.organization)
    org_user_1.roles << org_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(org_user_1)

    visit organization_dashboard_path(organization_slug: org_user_1.organization.slug)

    expect(page).to have_content("Your recipients have received $25 total!")
  end
end
