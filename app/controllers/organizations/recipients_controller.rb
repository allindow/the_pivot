class Organizations::RecipientsController < ApplicationController

  def show
    @recipient = Recipient.find_by(slug: params[:slug])
  end
end
