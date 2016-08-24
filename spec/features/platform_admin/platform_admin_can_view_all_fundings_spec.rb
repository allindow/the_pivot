require 'rails_helper'

RSpec.feature "Platform admin views all fundings" do
  scenario "they log in" do
    2.times { create(:recipient_funding) }
    plat = create(:user)
    role = Role.create(name: 'platform_admin')
    plat.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plat)

    visit platform_dashboard_index_path

    expect(page).to have_content("Recipients have received")
    expect(page).to have_link("Logout")
    expect(page).to have_link("Manage Organizations")
    expect(page).to have_link("View All Fundings")
  end

  xscenario "they view all fundings" do
    2.times { create(:recipient_funding) }
    plat = create(:user)
    role = Role.create(name: 'platform_admin')
    plat.roles << role
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plat)
    visit platform_dashboard_index_path

    click_link "View All Fundings"

    expect(current_path).to eq 'platform/fundings'
    expect(page).to have_link('Funding 1')
    expect(page).to have_link('Funding 2')

    click_link "Funding 1"

    expect(current_path).to eq 'platform/fundings/1'
    expect(page).to have_content(Funding.first.total_price)
    expect(page).to have_content(Funding.first.recipient.first.name)
    expect(page).to have_content(Funding.first.recipients.first.organization)
    expect(page).to have_content(Funding.first.recipient_funding.first.microloan_amount)
  end
end
