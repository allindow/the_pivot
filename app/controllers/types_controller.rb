class TypesController < ApplicationController
  
  def show
    @type = Type.find_by(name: params[:name])
    @recipients = @type.recipients
  end
end