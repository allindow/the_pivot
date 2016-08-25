class Organizations::DashboardController < ApplicationController
  def index
    if current_org_admin?(params[:organization_slug])
      @organization = current_user.organization
    else
      response.status = 403
      render file: "/public/403"
    end
  end
end
