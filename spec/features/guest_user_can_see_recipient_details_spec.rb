require 'rails_helper'

RSpec.feature "Guest User Sees Recipient Details" do
  scenario "guest clicks on recipient and sees their information" do
    # As a guest user,
    organization = create(:organization, status: 1) do |organization|
      organization.recipients.create(attributes_for(:recipient))
    end
    organization.recipients.create(attributes_for(:recipient,
                                                  name: "Jane Smith",
                                                  amount_received: 50.00,
                                                  description: "Jane needs help in the transition from military to civilian life",
                                                  country: "USA"))
    # When I visit /organizationname,
    visit root_path
    click_link organization.name
    expect(current_path).to eq "/#{organization.slug}"
    # I should see the organization name and description
    expect(page).to have_content(organization.name)
    expect(page).to have_content(organization.description)
    # I should see a list of people associated with that organization,
    # and I should see each person's name, country, and their basic request info,
    expect(page).to have_content(organization.recipients.first.name)
    expect(page).to have_content(organization.recipients.last.name)
    expect(page).to have_content(organization.recipients.first.description)
    expect(page).to have_content(organization.recipients.last.description)
    # and when I click on a person,
    click_link organization.recipients.first.name
    # I should be taken to /organization/recipient_name,
    expect(current_path).to eq "/#{organization.slug}/recipients/#{organization.recipients.first.slug}"
    # and I should see their pic, name, country, category, full bio/request details
    expect(page).to have_content(organization.recipients.first.name)
    expect(page).to have_content(organization.recipients.first.description)
    expect(page).to have_content(organization.name)
  end
end
