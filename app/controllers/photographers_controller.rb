class PhotographersController < ApplicationController

	def list
		contests = Contest.available.ids
		participants  = Participant.where(contest_id: contests)

		users = []
		participants.each do |participant|
			users << participant.user.id
		end

		usersOld = User.all.ids - users

		@participants = User.all.where(id: users)

		@photographers = User.all.where(id: usersOld).paginate(page: params[:page], per_page: 8)

	end

	def show
		@photographer = User.find_by_id(params[:id])
		@participants = Participant.approved.where(user: @photographer)
		@featured = @participants.sample()
	end

end
