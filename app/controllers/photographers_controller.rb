class PhotographersController < ApplicationController
	
	def list
		@photographers = User.all
	end

	def show
  		@photographer = User.find_by_id(params[:id])
  		@participants = Participant.all.where(user: @photographer).where(approved: true)
  	end

end
