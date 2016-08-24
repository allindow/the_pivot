class Admin::RecipientsController < Admin::BaseController
  before_action :set_recipient, only: [:edit, :update]

  def index
    @recipients = Recipient.all
  end

  def set_recipient
    @recipient = Recipient.find(params[:id])
  end
end
