class RecipientsController < ApplicationController

  def index
    @recipients = Recipient.all
  end

  def show
    @recipient = Recipient.find(params[:id])
  end
end