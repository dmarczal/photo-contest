class ContestsController < ApplicationController
  include ApplicationHelper
  before_action :logged_in_user, only: [:new_participant, :register]
  before_action :can_not_admin, only: [:new_participant, :register]
  before_action :set_contest, only: [:new_participant, :register]
  before_action :user_registered, only: [:new_participant, :register]
  before_action :between_deadline, only: [:new_participant, :register]


  def new_participant
    @participant = Participant.new
    render :register_photographer
  end

  def register
    @participant = Participant.new
    @participant = @contest.participants.build(user: current_user, picture: params[:participant][:picture], description: params[:participant][:description], accepted_term: params[:participant][:accepted_term], title: params[:participant][:title])
    respond_to do |format|
      if @participant.save
        flash[:success] = "Sua inscrição foi efetuada com sucesso! Aguarde pela aprovação." 
        format.html { redirect_to root_url, notice: 'Participant inscription was successfully created.' }
        #format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :register_photographer }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
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
    unless !current_user.admin?
     flash[:danger] = "Sua conta não permite inscrições em concursos!"
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
  
  #Check by  enrollment contest deadline
  def between_deadline
    if Time.now < @contest.opening_enrollment
      flash[:info] = "As incriçõs ainda não foram abertas!! Data de abertura: #{@contest.opening_enrollment.strftime("%d/%m/%Y")}"
      redirect_to root_url
      elsif Time.now > @contest.closing_enrollment+70.days
        flash[:info] = "As inscrições já foram encerradas!! Data de encerramento: #{@contest.closing_enrollment.strftime("%d/%m/%Y")}"
      redirect_to root_url
    end    
  	# if (@contest.opening_enrollment..@contest.closing_enrollment+50.days).cover?(Time.now)
  	# 	flash[:success] = "Inscrição efetuada com sucesso!"
  	# else
  	# 	flash[:danger] = "As inscrições já foram encerradas!!"
  	# 	redirect_to root_url
  	# end
  end

  # Check if user is registered in selected contest current  
  def user_registered
  	@user_found = @contest.users.find_by(id:current_user.id)
  	if @user_found.nil?
  		return true
    else
      flash[:danger] = "Você já está inscrito neste concurso!"
      redirect_to root_url #Redirecionar para o concurso q ele está inscrito
    end
  end

  def contest_params
    params.require(:contest).permit(:id)
  end

  def participant_params
    params.require(:participant).permit(:picture, :title, :description, :accepted_term)
  end
end

