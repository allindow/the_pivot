class RecipientsController < ApplicationController
  def index
    @recipients = Recipient.all
  end

  def show
    @recipient = Recipient.find(params[:id])
  end

  def create
    country = Country.find_or_create_by(name: params[:recipient][:country])
    organization = Organization.find(params[:organization_id])
    if country.valid? && organization.valid?
      @recipient = country.recipients.create(recipient_params.merge(organization: organization))
      @recipient.image_path = "http://www.thecircle-net.com/images/costum/other/commingSoon.png" if params[:recipient][:image_path].blank?
      if @recipient.save
        redirect_to "/admin/#{@recipient.organization.slug}/recipients"
        flash.now[:success] = "You have successfully added a recipient"
      else
        flash[:failure] = "Invalid information"
        redirect_to "/#{organization.slug}/recipients/new"
      end
    else
      flash[:failure] = "Invalid information"
      redirect_to "/#{organization.slug}/recipients/new"
    end
  end

  def destroy
    recipient = Recipient.find(params[:id])
    recipient.delete
    params.delete("id")
    redirect_to(:back)
  end

  def edit
    @recipient = Recipient.find(params[:id])
  end

  def update
    # require "pry"; binding.pry
    @recipient = Recipient.find(params[:id])
    @recipient.update_attributes(recipient_params)
    @recipient.image_path = "http://www.thecircle-net.com/images/costum/other/commingSoon.png" if params[:recipient][:image_path].blank?
    if @recipient.save
      redirect_to recipient_path
    else
      render :edit
      flash[:notice] = "Invalid"
    end
  end

  private

    def recipient_params
      params.require(:recipient).permit(:name, :description, :image_path)
    end
end
