class Api::V1::ProgressController < ApplicationController
  # respond_to :json

  def index
    # byebug
    recipient = Recipient.find(params[:id].to_i)
    @progress = recipient.amount_received.to_i
    # respond_with @progress
    render json: @progress
  end
end
