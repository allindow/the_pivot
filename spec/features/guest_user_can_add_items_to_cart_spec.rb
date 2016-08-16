require 'rails_helper'

RSpec.feature "Guest User can add recipient to their cart" do
   scenario "when on the homepage, guest user clicks to add an recipient to cart" do
      recipient = FactoryGirl.create(:recipient)

      visit root_path
      expect(page).to have_link("Cart: 0")

      click_link "Homes for Humanity"
      expect(current_path).to eq("/cause/homes-for-humanity")

      expect(page).to have_content("Homes for Humanity")


      expect(page).to have_link("Cart: 1")
      expect(page).to have_content("You now have selected 1 #{creature.name}")

      click_link "Cart: 1"

      expect(current_path).to eq("/cart")
      expect(page).to have_content(creature.name)
      expect(page).to have_content(creature.price)
      expect(page).to have_content(creature.description)
      expect(page).to have_css(:img)
      expect(page).to have_content("Total:")
   end
end
