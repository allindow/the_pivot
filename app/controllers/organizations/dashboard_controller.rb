class Organizations::DashboardController < ApplicationController

  def index
    @organization = Organization.find_by(slug: params[:slug])
  end
end
