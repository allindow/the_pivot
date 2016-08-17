class OrdersController < ApplicationController
  helper_method :orders

  def index
    orders
  end

  def create
    if current_user && @cart.empty?
      flash[:notice] = "Your cart is empty."
      redirect_to cart_path
    elsif current_user && @cart.not_empty?
      create_order
      flash[:notice] = "Order was successfully placed"
      redirect_to @order
    else
      redirect_to login_path
    end
  end

  def orders
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def create_order
    @order = current_user.orders.create
    params[:contents].each do |key, value|
      @order.recipient_fundings.create(creature_id: key, quantity: value)
    end
    session[:cart].clear
    @order.assign_total_price
  end

  def change_order_status
    @order.update_attributes(status: "paid")
  end
end
