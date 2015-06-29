class PhotographersController < ApplicationController
	
	def list
		@photographers = User.all
	end

	def show
  		@photographer = User.find_by_id(params[:id])
  	end

end
