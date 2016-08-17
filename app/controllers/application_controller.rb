class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :creature_orginizations,
                :creature,
                :current_user,
                :current_admin?,
                :find_creature,
                :non_admin?

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def creature_orginizations
    Organization.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def find_creature(name)
    Creature.find_by(name: name)
  end

  def current_order
    current_user.orders.last
  end

end
