class Admin::Organization::UsersController < ApplicationController
  before_action :find_organization

  def index
      @admins = @organization.users
  end

  def new
    @user = @organization.users.new
  end

  def update
    if current_org_admin_updating_non_org_admin?
        promote_to_org_admin
    elsif @user.org_admin?
        user_not_found
    else
      flash.now[:failure] = "Could not find user: #{params[:user][:username]}"
      render :new
    end
  end

  def find_organization
    @organization = Organization.find_by(slug: params[:organization_slug])
  end

  private
    def current_org_admin_updating_non_org_admin?
      @user = User.find_by(username: params[:user][:username])
      @user.not_org_admin? && current_user.org_admin?
    end

    def promote_to_org_admin
      @user.promote_to_org_admin(@organization)
      flash[:success] = "You've added #{@user.username} as an admin"
      redirect_to "/admin/#{@organization.slug}/users"
    end

    def user_not_found
      flash[:failure] = "Could not add user"
      redirect_to "/admin/#{@organization.slug}/users"
    end
end
