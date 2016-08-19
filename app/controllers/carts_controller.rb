class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_recipient, only: [:create, :destroy]

  def create
    @cart.add_recipient(@recipient.id, params[:loan_amount])
    session[:cart] = @cart.contents
    flash[:notice] = "You're helping #{@recipient.name}."
    redirect_to request.referrer
  end

  def index
    @recipients = @cart.recipients
  end

  def update
    if params[:add]
      session[:cart][params[:add]] += 10
    else
      qty = session[:cart][params[:remove]]
      qty -= 10 unless qty == 0
      session[:cart][params[:remove]] = qty
    end
    redirect_to cart_path
  end

  def destroy
    session[:cart] = @cart.contents
    session[:cart][@recipient.id] = 0
    session[:removed_recipient] = @recipient.id
    delete_link = "<a href=\"#{url_for(@recipient)}\">#{@recipient.name}</a>"
    flash[:delete] = "Successfully removed #{delete_link} from your cart"
    redirect_to cart_path
  end

  def set_recipient
    @recipient = Recipient.find(params[:recipient_id])
  end
end
