class PhotographersController < ApplicationController
  def list
  end

  def show
  	@photographer = User.find_by_id(params[:id])
  end
end
