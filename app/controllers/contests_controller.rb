class ContestsController < ApplicationController
  include ApplicationHelper
  before_action :logged_in_user, only: [:new_participant, :register]
  before_action :can_not_admin, only: [:new_participant, :register]
  before_action :set_contest, only: [:new_participant, :register]
	#before_action :user_is_registered, only: [:new_participant, :register]
	

	def new_participant
		render :register_photographer
	end

	def register
    begin
      @contest.participants.create!(user: current_user)
      flash[:success] = "Registrado com sucesso!"
    rescue
      flash[:danger] = "Você já está inscrito neste concurso!"
      render :register_photographer
    end
  end

  def list
    @contests = Contest.list#.paginate(page: params[:page], per_page: 10)
  end

  def show
  	@contest = Contest.find_by_id(params[:id])
  end
  
  def archive
  	@contests = Contest.old.paginate(page: params[:page], per_page: 10)
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

  # Check if user is admin
  def can_not_admin
    @u = current_user.admin?
    unless !current_user.admin?
     flash[:danger] = "Seu login não permite incrições em concursos!"
     redirect_to root_url
   end
 end

  # Set Contest
  def set_contest
  	@contest = Contest.find_by(id:params[:id]) 
  	if @contest.nil?
  		flash[:danger] = "Concurso inexistente!"
  		redirect_to root_url
  	end
  end

  
  # Check by  enrollment contest deadline
  # def between_deadline
  # 	if (@contest.opening_enrollment..@contest.closing_enrollment+50.days).cover?(Time.now)
  # 		flash[:success] = "Inscrição efetuada com sucesso!"

  # 	else
  # 		flash[:danger] = "Inscrições encerradas!!"
  # 		redirect_to root_url
  # 	end
  # end

  # Check if user can be sign up in contest
  def can_be_registered?
  	@registered = @contest.users.find_by(id:current_user.id)
  	if @registered.nil?
  		return true
     return false
   end
 end

 def contest_params
   params.require(:contest).permit(:id)
 end
end

