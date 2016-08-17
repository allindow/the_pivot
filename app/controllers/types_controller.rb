class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find_by(name: params[:name])
    @creatures = @organization.creatures
  end
end
