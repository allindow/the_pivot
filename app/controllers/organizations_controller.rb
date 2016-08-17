class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find_by(name: params[:name])
    @recipients = @organization.recipients
  end
  
  def new
    @organization = Organization.new
  end
  
  def index
    @organizations = Organization.active_only
  end
  
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to root_path
      flash[:success] = "You have submitted your organization application. We'll be in touch once we review it."
    else 
      flash[:failure] = "Invalid Information"
      redirect_to new_organization_path  
    end
  end
  
  private
  
  def organization_params
    params.require(:organization).permit(:name, :description, :image_path)
  end
end

