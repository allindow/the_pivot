require 'rails_helper'

RSpec.feature "platform admin can view cart" do
  scenario "logged in platform admin views cart" do
    plat = create(:user)
    role = Role.create(name: 'platform_admin')
    plat.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plat)

    visit cart_path

    expect(page).to have_content("Cart Summary")
  end
end
