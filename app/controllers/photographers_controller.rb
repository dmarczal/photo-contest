class PhotographersController < ApplicationController
	
	def list
		@photographers = User.all.paginate(page: params[:page], per_page: 10)
	end

	def show
  		@photographer = User.find_by_id(params[:id])
  		@participants = Participant.approved.where(user: @photographer)
  		@featured = @participants.sample()
  	end

end
