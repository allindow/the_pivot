class Platform::FundingsController < ApplicationController
  def index
    @fundings = Funding.all
  end
end
