class Admin::Organization::RecipientsController < ApplicationController

  def index
    @organization = Organization.find_by(slug: params[:organization_slug])
    @recipients = @organization.recipients
    # require "pry"; binding.pry
  end
end