class Organizations::RecipientsController < ApplicationController
  def show
    @recipient = Recipient.find_by(slug: params[:slug])
  end

  def new
    @countries = Country.order(:name).pluck(:name)
    @organization = Organization.find_by(slug: params[:organization_slug])
    @recipient = Recipient.new
  end
end
