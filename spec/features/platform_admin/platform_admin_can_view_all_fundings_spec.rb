require 'rails_helper'

RSpec.feature "Platform admin views all fundings" do
  scenario "platform admin can login" do
    2.times { create(:recipient_funding) }
    plat = create(:user)
    role = Role.create(name: 'platform_admin')
    plat.roles << role

    visit platform_dashboard_index_path
    expect(response.status).to eq(404)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plat)

    visit platform_dashboard_index_path
    expect(page).to have_link("Logout")
    expect(page).to have_link("My Organization")
    expect(page).to have_link("My Account")

  end
end
