class Platform::Organization::UsersController < ApplicationController

  def new
    @organization = Organization.find_by(slug: params[:organization_slug])
    @user = @organization.users.new
  end
end
