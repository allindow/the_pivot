class Admin::Organization::RecipientsController < ApplicationController

  def index
    @organization = Organization.find_by(slug: params[:organization_slug])
    @recipients = @organization.recipients
  end

  def edit
    @recipient = Recipient.find(params[:id])
  end

  private

    def recipient_params
      params.require(:recipient).permit(:name, :description, :country, :image_path, :amount_received)
    end
end
