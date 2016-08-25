class RecipientsController < ApplicationController
  before_action :set_recipient, except: [:index, :create]

  def index
    @recipients = Recipient.active_only
  end

  def show
    if Recipient.active_only.include?(@recipient)
      @recipient
    else
      redirect_to dashboard_path
      flash[:failure] = "Can't find what you're looking for"
    end
  end

  def create
    @country = Country.find_or_create_by(name: params[:recipient][:country])
    @organization = Organization.find(params[:organization_id])
    if country_and_org_exist?
      @recipient = @country.recipients.create(recipient_params.merge(organization: @organization))
      check_for_image_path
      check_if_recipient_saved
    else
      flash[:failure] = "Invalid information"
      redirect_to "/#{@organization.slug}/recipients/new"
    end
  end

  def destroy
    @recipient.delete
    params.delete("id")
    redirect_to(:back)
  end

  def edit
  end

  def update
    @recipient.update_attributes(recipient_params)
    check_for_image_path
     if @recipient.save
      redirect_to recipient_path
    else
      render :edit
      flash[:notice] = "Invalid"
    end
  end

  private
    def set_recipient
      @recipient = Recipient.find(params[:id])
    end

    def recipient_params
      params.require(:recipient).permit(:name, :description, :image_path)
    end

    def country_and_org_exist?
      @country.valid? && @organization.valid?
    end

    def check_for_image_path
      @recipient.image_path = "http://www.thecircle-net.com/images/costum/other/commingSoon.png" if params[:recipient][:image_path].blank?
    end

    def check_if_recipient_saved
      if @recipient.save
        redirect_to "/admin/#{@recipient.organization.slug}/recipients"
        flash.now[:success] = "You have successfully added a recipient"
      else
        flash[:failure] = "Invalid information"
        redirect_to "/#{@organization.slug}/recipients/new"
      end
    end
end
