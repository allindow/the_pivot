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
    if @recipient.retired
      @recipient.activate
    else
      @recipient.retire
    end
    if @recipient.save
      if @recipient.retired
        flash[:success] = "#{@recipient.name} is inactive"
      else
        flash[:success] = "#{@recipient.name} has been reactivated"
      end
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
