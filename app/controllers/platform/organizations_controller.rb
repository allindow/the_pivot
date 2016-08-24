class Platform::OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def update
    @organization = Organization.find(params[:id])
    if params[:name] == "activated"
      @organization.activate_organization_status
      @organization.users.first.roles << Role.find_by(name: "org_admin")
    elsif params[:name] == "denied"
      @organization.deny_organization_status
    elsif params[:name] == "deactivated"
      @organization.deactivate_organization_status
    end
    redirect_to platform_organizations_path
  end
end
