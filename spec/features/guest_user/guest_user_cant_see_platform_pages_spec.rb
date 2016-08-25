require 'rails_helper'

RSpec.feature "Guest user can't see platform pages" do
  scenario "they can't see platform dashboard" do
    visit platform_dashboard_index_path

    expect(page).to have_content "Couldn't find what you're looking for!"
    expect(page).to_not have_content("Recipients have received")
    expect(page).to_not have_link("Manage Organizations")
    expect(page).to_not have_link("View All Fundings")
  end
end
