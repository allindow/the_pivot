class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find_by(slug: params[:slug])
    @recipients = @organization.recipients
  end
end
