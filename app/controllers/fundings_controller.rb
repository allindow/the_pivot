class FundingsController < ApplicationController
  helper_method :fundings

  def index
    fundings
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

  def fundings
    @fundings = current_user.fundings
  end

  def show
    @funding = Funding.find(params[:id])
  end

  private

  def create_funding
    @funding = current_user.fundings.create
    params[:contents].each do |key, value|
      @funding.recipient_fundings.create(recipient_id: key, microloan_amount: value)
    end
    session[:cart].clear
    @funding.assign_total_price
  end

  def change_funding_status
    @funding.update_attributes(status: "paid")
  end
end
