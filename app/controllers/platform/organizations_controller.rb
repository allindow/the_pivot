class Platform::OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def update
    @organization = Organization.find(params[:id])
    if params[:name] == "activated"
      @organization.update_attributes(status: "active")
      @organization.users.first.roles << Role.find_by(name: "org_admin")
    elsif params[:name] == "denied"
      @organization.update_attributes(status: "denied")
      @organization.users.first.update_attributes(organization_id: nil)
    end
    redirect_to platform_organizations_path
  end
end
