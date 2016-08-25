require 'rails_helper'

RSpec.feature "Org admin can add recipients to organization " do
  scenario "org admin logs in and creates a new recipient" do
    Country.create(name: "Guatemala")
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit organization_dashboard_path(organization_slug: user.organization.slug)

    click_link "Manage Recipients"

    expect(current_path).to eq "/admin/#{organization.slug}/recipients"

    expect(page).to have_link("Add Recipient")

    click_link "Add Recipient"

    expect(current_path).to eq "/#{organization.slug}/recipients/new"

    fill_in "Name", with: "Bill"
    fill_in "Description", with: "Bill also likes building huts"
    select "Guatemala", from: "Country"
    fill_in "Image path", with: "http://vignette2.wikia.nocookie.net/ghostbusters/images/1/11/Bill_Murray.jpeg/revision/latest?cb=20081013140955"
    click_button "Create Recipient"

    expect(current_path).to eq "/admin/#{organization.slug}/recipients"

    expect(page).to have_content("Bill")
    expect(page).to have_content("Bill also likes building huts")
  end

  scenario "org admin tries to add recipient without name" do
    Country.create(name: "Guatemala")
    organization = Organization.create!(name:"Homes for Humanity", description: "We build homes", status: 1)
    user = organization.users.create(username: 'fiona@cat.com', password: 'password')
    role = Role.create(name: 'org_admin')
    user.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit organization_dashboard_path(organization_slug: user.organization.slug)

    click_link "Manage Recipients"

    click_link "Add Recipient"

    fill_in "Description", with: "Bill also likes building huts"
    select "Guatemala", from: "Country"
    fill_in "Image path", with: "http://vignette2.wikia.nocookie.net/ghostbusters/images/1/11/Bill_Murray.jpeg/revision/latest?cb=20081013140955"
    click_button "Create Recipient"

    expect(current_path).to eq "/#{organization.slug}/recipients/new"
    expect(page).to have_content("Invalid information")
  end
end
