class Platform::Organization::UsersController < ApplicationController

  def new
    @organization = Organization.find_by(slug: params[:organization_slug])
    @user = @organization.users.new
  end

  def update
    @user = User.find_by(username: params[:user][:username])
    @organization = Organization.find_by(slug: params[:organization_slug])
    @role = Role.find_or_create_by(name: "org_admin")
    if @user && @user.org_admin? == false
      if current_user.org_admin? || current_user.platform_admin?
        @user.roles << @role
        @user.update!(organization_id: @organization.id)
        flash[:success] = "You've added #{@user.username} as an admin"
      end
      redirect_to platform_organizations_path
    elsif @user.org_admin?
      flash[:failure] = "Could not add user"
      redirect_to "/admin/#{@organization.slug}/users"
    else
      flash.now[:failure] = "Could not find user: #{params[:user][:username]}"
      render :new
    end
  end

end
