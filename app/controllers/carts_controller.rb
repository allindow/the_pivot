class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_recipient, only: [:create, :destroy]
  
  def create
    @cart.add_recipient(@recipient.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have selected #{pluralize(@cart.count_of(@recipient.id), @recipient.name)}."
    redirect_to root_path
  end
  
  def index
    @recipients = @cart.recipients
  end
  
  def update
    if params[:add]
      session[:cart][params[:add]] += 1
    else
      qty = session[:cart][params[:remove]]
      qty -= 1 unless qty == 0
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