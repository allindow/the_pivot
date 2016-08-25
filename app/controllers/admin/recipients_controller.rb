class Admin::RecipientsController < Admin::BaseController
  before_action :set_recipient, only: [:edit, :update]

  def index
    @recipients = Recipient.all
  end

  def update
    @recipient = Recipient.find(params[:id])
    @recipient.update_attributes(recipient_params)
    if @recipient.save
      redirect_to recipients_path
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
    params.require(:recipient).permit(:name, :description, :country, :image_path, :amount_received)
  end
end