class Platform::Organization::UsersController < ApplicationController
  before_action :set_org, except: [:index, :create]

  def new
    @user = @organization.users.new
  end

  def update
    @user = User.find_by(username: params[:user][:username])
    if @user.not_org_admin?
      promote_to_org_admin
      redirect_to platform_organizations_path
    elsif @user.org_admin?
      user_not_found
    else
      flash.now[:failure] = "Could not find user: #{params[:user][:username]}"
      render :new
    end
  end

  private
    def set_org
      @organization = Organization.find_by(slug: params[:organization_slug])
    end

    def promote_to_org_admin
      if current_user.org_admin? || current_user.platform_admin?
        @user.promote_to_org_admin(@organization)
        flash[:success] = "You've added #{@user.username} as an admin"
      end
    end

    def user_not_found
      flash[:failure] = "Could not add user"
      redirect_to "/admin/#{@organization.slug}/users"
    end
end
