class Platform::RecipientsController < ApplicationController

  def index
    @organizations = Organization.all
  end
  
  def edit
    @recipient = Recipient.find(params[:id])
  end
  
  def update
    @recipient = Recipient.find(params[:id])
    @recipient.update_attributes(name: params[:recipient][:name]) if params[:recipient]
    @recipient.update_attributes(description: params[:recipient][:description]) if params[:recipient]
    @recipient.update_attributes(image_path: params[:recipient][:image_path]) if params[:recipient]
    redirect_to platform_recipients_path
  end
end
