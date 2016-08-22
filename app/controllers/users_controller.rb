class UsersController < ApplicationController
  before_action :non_admin?, only: [:show]

  def non_admin?
    if current_platform_admin?
      response.status = 403
      render file: "/public/403"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.roles << Role.create(name: "registered_user")
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user)
      flash.now[:sucess] = "You have successfully created an account!"
    else
      flash[:failure] = "Invalid Information"
      redirect_to new_user_path
    end
  end

  def update
    organization = Organization.find_by(slug: params[:organization_slug])
    role = Role.find_or_create_by(name: "org_admin")
    user = User.find_by(username: params[:user][:username])
    if user
      user.roles << role
      user.update!(organization_id: organization.id)
      flash[:success] = "You've added #{user.username} as an admin"
      redirect_to "/admin/#{organization.slug}/users"
    else
      flash.now[:failure] = "Could not find user: #{params[:user][:username]}"
      render :new
    end
  end

  def show
    if session[:user_id]
      @user = current_user
    else
      response.status = 403
      render file: "/public/403"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    session.delete("user_id")
    params.delete("id")
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
