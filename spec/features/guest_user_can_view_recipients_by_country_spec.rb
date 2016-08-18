require 'rails_helper'

RSpec.feature "Guest user can view recipients by country" do
    scenario "when they visit the homepage" do
    country1 = Country.create!(name: "Ghana")
    country2 = Country.create!(name: "Japan")
    organization = Organization.create(name: "Hope for Veterans")
    recipient1 = organization.recipients.create!(name: "Haysha", description: "need a sewing machine", country: country1)
    recipient2 = organization.recipients.create!(name: "Kaya", description: "want a restaurant", country: country1)

    visit root_path

    click_on "Needs by Country"
    click_on "Ghana"

    expect(current_path).to eq '/ghana/needs'

      expect(page).to have_content("Haysha")
      expect(page).to have_content("need a sewing machine")
      expect(page).to have_content("Hope for Veterans")
      expect(page).to have_content("Kaya")
      expect(page).to have_content("want a restaurant")
  end
end
