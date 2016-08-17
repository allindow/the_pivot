require 'rails_helper'

RSpec.feature "Guest User Sees Recipient Details" do
  scenario "guest clicks on recipient and sees their information" do
    organization = create(:organization, status: 1)
    organization.recipients << create(:recipient)
    organization.recipients << create(:recipient)
    
    visit root_path
    click_link organization.name
    expect(current_path).to eq "/#{organization.slug}"
    expect(page).to have_content(organization.name)
    expect(page).to have_content(organization.description)
    expect(page).to have_content(organization.recipients.first.name)
    expect(page).to have_content(organization.recipients.last.name)
    expect(page).to have_content(organization.recipients.first.description)
    expect(page).to have_content(organization.recipients.last.description)
    click_link organization.recipients.first.name
    expect(current_path).to eq "/#{organization.slug}/recipients/#{organization.recipients.first.slug}"
    expect(page).to have_content(organization.recipients.first.name)
    expect(page).to have_content(organization.recipients.first.description)
    expect(page).to have_content(organization.name)
  end
end
