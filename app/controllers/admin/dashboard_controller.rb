class Admin::DashboardController < Admin::BaseController
  def index
    @fundings = Funding.all
    @status = @fundings.pluck(:status).uniq
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes(user_params)
    if current_user.save
      redirect_to admin_dashboard_index_path
    else
      render :edit
      flash[:notice] = "Invalid"
    end
  end

  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user
      user.admin = true
      flash[:notice] = "#{params[:user][:username]} is now an admin!"
    else
      flash[:notice] = "#{params[:user][:username]} was not found"
    end
    redirect_to admin_dashboard_index_path
  end

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end
end
