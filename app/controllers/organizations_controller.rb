class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find_by(slug: params[:slug])
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
      current_user.update_attributes(organization_id: @organization.id)
      redirect_to "/dashboard"
      flash[:success] = "You have submitted your organization application. We'll be in touch once we review it."
    else
      flash[:failure] = "Invalid Information"
      redirect_to new_organization_path
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization
      @organization.update_attributes(organization_params)
      flash[:success] = "Your organization has been updated"
    else
      flash[:failure] = "Information is not valid."
    end
      redirect_to "/#{@organization.slug}/dashboard"
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :description, :image_path, :slug)
  end
end
