require 'rails_helper'

RSpec.feature "registered user cant view an inactive orgs recipients" do
  scenario "registered user tries to visit in inactive orgs recipient" do
    organization = create(:organization, status: 2)
    organization.recipients << create(:recipient)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit recipient_path(organization.recipients.first)

    expect(current_path).to eq dashboard_path

    expect(page).to have_content("Can't find what you're looking for")
  end
end
