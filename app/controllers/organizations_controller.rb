class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.active_only
  end

  def show
    organizations = Organization.active_only
    if @organization = organizations.find_by(slug: params[:slug])
      @recipients = @organization.recipients
    else
      flash[:failure] = "Can't find what you're looking for"
      redirect_to dashboard_path
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      current_user.update_attributes(organization_id: @organization.id)
      redirect_to dashboard_path
      flash[:success] = "You have submitted your organization application. We'll be in touch once we review it."
    else
      flash[:failure] = "Invalid information."
      render :new
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(organization_params)
      flash[:success] = "Your organization has been updated!"
      redirect_to "/#{@organization.slug}/dashboard"
    else
      flash.now[:failure] = "Invalid information."
      render :new
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :description, :image_path, :slug)
  end
end
