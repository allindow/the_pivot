class FundingsController < ApplicationController
  helper_method :fundings

  def index
    @fundings = current_user.fundings
  end

  def create
    if current_user && @cart.empty?
      flash[:notice] = "Your cart is empty."
      redirect_to cart_path
    elsif current_user && @cart.not_empty?
      create_funding
      flash[:notice] = "Funding was successfully placed"
      redirect_to @funding
    else
      redirect_to login_path
    end
  end

  def show
    if current_platform_admin?
      @funding = Funding.find(params[:id])
    elsif current_user_order?
      @funding = current_user.fundings.find(params[:id])
    else
      redirect_to root_path
    end
  end

  private

  def create_funding
    @funding = current_user.fundings.create
    params[:contents].each do |key, value|
      @funding.recipient_fundings.create(recipient_id: key, microloan_amount: value)
      @funding.update_recipient_total(key, value)
    end
    session[:cart].clear
    @funding.assign_total_price
  end

  def change_funding_status
    @funding.update_attributes(status: "paid")
  end

  def current_user_order?
    current_user.fundings.exists? && current_user.fundings.find(params[:id]) rescue nil
  end
end
