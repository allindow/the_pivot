class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :recipient_organizations,
                :recipient,
                :current_user,
                :current_platform_admin?,
                :find_recipient,
                :non_admin?

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
    current_user && current_user.role == 1
  end

  def find_recipient(name)
    Recipient.find_by(name: name)
  end

  def current_funding
    current_user.fundings.last
  end

end
