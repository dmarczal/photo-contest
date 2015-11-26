class ContestsController < ApplicationController
  #before_action :logged_in_user

  def list
    @current_user = current_user
    @contests = Contest.list.paginate(page: params[:page], per_page: 9)
  end

  def show
  	@contest = Contest.find_by_id(params[:id])
    @participants = Participant.approved.where(contest_id: @contest.id)
    if @contest.open?
      @partial_podium = @participants.joins("LEFT OUTER JOIN votes ON votes.participant_id = participants.id").group("participants.id").order("count(votes.participant_id) desc")
    end
    flash[:info] = "Ainda não existem inscrições aprovadas para este concurso." unless @participants.count > 0
    if @contest.closed?
      @podium = Participant.podium(@contest.id)
    end
  end

  def archive
  	@contests = Contest.old.paginate(page: params[:page], per_page: 10)
  end

  def hall_of_fame
    @photographers_first = User.order(first: :desc, second: :desc, third: :desc).limit(3)
    @photographers_last = User.order(first: :desc, second: :desc, third: :desc).limit(7).offset(3)
  end

  private

	# Check by user logged
	def logged_in_user
    store_location
    unless user_signed_in?
     flash[:danger] = "Efetue seu login para se inscrever no concurso!"
     redirect_to new_user_session_path
   end
  end

end
