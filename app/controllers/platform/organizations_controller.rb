class Platform::OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update_attributes(name: params[:organization][:name]) if params[:organization]
    @organization.update_attributes(description: params[:organization][:description]) if params[:organization]
    @organization.update_status(params[:status])
    redirect_to platform_organizations_path
  end
  
  def edit
    @organization = Organization.find(params[:id])
  end
end
