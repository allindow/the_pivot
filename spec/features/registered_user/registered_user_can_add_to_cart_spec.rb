require 'rails_helper'

RSpec.feature "Registered user can add to cart" do
  scenario "when logged in they can add to cart" do
    user = create(:user)
    recipient = create(:recipient)
    organization = recipient.organization
    organization.update_attributes(status: "active")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit recipients_path
    expect(page).to have_content("Cart: $0")
    click_on organization.name

    expect(current_path).to eq organization_path(slug: organization.slug)
    select("20")
    click_button("Lend")
    expect(page).to have_content("Cart: $20")
    expect(page).to have_content("You're helping #{recipient.name}")
  end
end
