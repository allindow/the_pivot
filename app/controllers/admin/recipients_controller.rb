class Admin::RecipientsController < Admin::BaseController
  before_action :set_recipient, only: [:edit, :update]
  
  def index
    @recipients = Recipient.all
  end
  
  def edit
  end
  
  def update
    @recipient.update_attributes(recipient_params)
    if @recipient.save
      redirect_to admin_recipients_path
    else
      render :edit
      flash[:notice] = "Invalid"
    end
  end
  
  def set_recipient
    @recipient = Recipient.find(params[:id])
  end
  
  private
  
  def recipient_params
    params.require(:recipient).permit(:name, :price, :description, :retired, :image_path)
  end
end