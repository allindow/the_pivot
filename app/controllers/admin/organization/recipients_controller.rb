class Admin::Organization::RecipientsController < ApplicationController
  def index
    @organization = Organization.find_by(slug: params[:organization_slug])
    @recipients = @organization.recipients
  end

  def edit
    @recipient = Recipient.find(params[:id])
  end

  def update
    @recipient = current_user.organization.recipients.find(params[:id])
    @recipient.toggle_status
    if @recipient.save
      flash[:succes] = @recipient.status_message
      redirect_to "/admin/#{@recipient.organization.slug}/recipients"
    else
      flash[:failure] = "Something went wrong"
      redirect_to "/admin/#{@recipient.organization.slug}/recipients"
    end
  end

  private

    def recipient_params
      params.require(:recipient).permit(:name, :description, :country, :image_path, :amount_received)
    end
end
