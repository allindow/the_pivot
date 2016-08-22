class Admin::Organization::RecipientsController < ApplicationController

  def index
    @organization = Organization.find_by(slug: params[:organization_slug])
    @recipients = @organization.recipients
    # require "pry"; binding.pry
  end

  def edit
    @recipient = Recipient.find(params[:id])
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

  private

    def recipient_params
      params.require(:recipient).permit(:name, :description, :country, :image_path, :amount_received)
    end
end
