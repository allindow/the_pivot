class Admin::Organization::RecipientsController < ApplicationController
  def index
    @organization = Organization.find_by(slug: params[:organization_slug])
    @recipients = @organization.recipients
  end

  def update
    @recipient = current_user.organization.recipients.find(params[:id])
    @recipient.toggle_status
    if @recipient.save
      flash[:success] = @recipient.status_message
      redirect_to "/admin/#{@recipient.organization.slug}/recipients"
    else
      flash[:failure] = "Invalid method."
      redirect_to "/admin/#{@recipient.organization.slug}/recipients"
    end
  end
end
