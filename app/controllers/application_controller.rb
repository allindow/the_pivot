class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_cart,
                :authorize!
  helper_method :recipient_organizations,
                :recipient,
                :current_user,
                :current_platform_admin?,
                :find_recipient,
                :non_admin?

  def authorize!
    unless authorize?
      redirect_to root_url
      flash[:warning] = "Couldn't find what you're looking for!"
    end
  end

  def authorize?
    PermissionService.new(current_user).allow?(params[:controller], params[:action])
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def recipient_organizations
    Organization.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_platform_admin?
    current_user && current_user.roles.include?("platform_admin")
  end

  def find_recipient(name)
    Recipient.find_by(name: name)
  end

  def current_funding
    current_user.fundings.last
  end

  def countries
    Country.all
  end
end
