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

  scenario "they view all fundings" do
    2.times { create(:recipient_funding) }
    plat = create(:user)
    role = Role.create(name: 'platform_admin')
    plat.roles << role
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plat)
    visit platform_dashboard_index_path

    click_link "View All Fundings"

    expect(current_path).to eq platform_fundings_path
    expect(page).to have_link("Funding #{Funding.first.id}")
    expect(page).to have_link("Funding #{Funding.last.id}")

    click_link "Funding #{Funding.first.id}"

    expect(current_path).to eq "/fundings/#{Funding.first.id}"
    expect(page).to have_content(Funding.first.total_price)
    expect(page).to have_content(Funding.first.recipients.first.name)
    expect(page).to have_content(Funding.first.recipient_fundings.first.microloan_amount)
  end
end
