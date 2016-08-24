class Platform::RecipientsController < ApplicationController

  def index
    @organizations = Organization.all
  end
end
