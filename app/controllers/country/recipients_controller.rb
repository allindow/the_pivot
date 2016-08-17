class Country::RecipientsController < ApplicationController
  def index
    @recipients = Recipient.where(country: find_country)
  end

  private
    def find_country
      Country.find_by(name: params[:country_slug].capitalize)
    end
end
