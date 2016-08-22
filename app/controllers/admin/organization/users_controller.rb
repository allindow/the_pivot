class Admin::Organization::UsersController < ApplicationController

  def index
    @organization = Organization.find_by(slug: params[:organization_slug])
    @admins = @organization.users
    # require "pry"; binding.pry
  end

  def new
    @organization = Organization.find_by(slug: params[:organization_slug])
    @user = @organization.users.new
  end

  def create
    organization = Organization.find_by(slug: params[:organization_slug])
    role = Role.find_or_create_by(name: "org_admin")
    user = User.find_by(username: params[:user][:username])
    if user
      user.roles << role
      org_users = organization.users
      org_users << user
      # flash[:success] = "You've added #{user.username} as an admin"
      redirect_to "/admin/#{organization.slug}/users"
    else
      flash.now[:failure] = "Could not find user: #{params[:user][:username]}"
      render :new
    end
  end
end
