class Funding::ChargesController < Funding::BaseController

  #
  # def create
  # byebug
  #   # @order.update_attributes(cart_token: stripe_params["stripeToken"])
  #   # @order.process_payment
  #   # @order.save
  #   # redirect_to orders_path
  #   @order = current_order
  #   flash[:notice] = "Order was successfully placed"
  # end
  # #
  # private
  #
  # def stripe_params
  #   params.permit(:stripeToken)
  # end
  #   @amount = 500
  #
  #   customer = Stripe::Customer.create(
  #     :email => params[:stripeEmail],
  #     :source => params[:stripeToken]
  #   )
  #
  #   charge = Stripe::Charge.create(
  #     :customer => customer.id,
  #     :amount => @amount,
  #     :description => 'Rails Stripe customer',
  #     :currency => 'usd'
  #   )
  #
  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to new_charge_path
  # end
end
