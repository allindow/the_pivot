class UsersController < ApplicationController
  before_action :non_admin?, only: [:show]
  before_action :find_user, only: [:update, :destroy, :edit]

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
      create_user
    else
      fail_user
    end
  end

  def update
    if current_user.platform_admin?
      @user.update_attributes(username: params[:user][:username], password: params[:user][:password])
      redirect_to platform_organizations_path
    end
  end

  def show
    if session[:user_id]
      @user = current_user
    end
  end

  def edit
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def create_user
    @user.register_role
    session[:user_id] = @user.id
    redirect_to dashboard_path(@user)
    flash.now[:sucess] = "You have successfully created an account!"
  end
  
  def fail_user
    flash[:failure] = "Invalid Information"
    redirect_to new_user_path
  end
    
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
