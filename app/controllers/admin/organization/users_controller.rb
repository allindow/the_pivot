class Admin::Organization::UsersController < ApplicationController

  def index
      @organization = Organization.find_by(slug: params[:organization_slug])
      @admins = @organization.users
  end

  def new
    @organization = Organization.find_by(slug: params[:organization_slug])
    @user = @organization.users.new
  end
end
