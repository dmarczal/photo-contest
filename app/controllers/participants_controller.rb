class ParticipantsController < ApplicationController

	before_action :logged_in_user
	before_action :can_not_admin
	before_action :set_contest, only: [:new]
	before_action :user_registered, only: [:create]
	before_action :between_deadline, only: [:new, :create]

	def index
		@participants = Participant.all.where("user_id = ?", current_user.id) 
		if @participants.count <= 0 
			flash[:info] = "Você ainda não possui nenhuma inscrição! Inscreva-se já!"
			redirect_to contests_path
		end
	end

	def new
		@participant = Participant.new
		redirect_to contests_path unless !@contest.nil?
	end

	def create
		
		@participant = @contest.participants.build(user: current_user, picture: params[:participant][:picture], description: params[:participant][:description], accepted_term: params[:participant][:accepted_term], title: params[:participant][:title])
		respond_to do |format|
			if @participant.save
				flash[:success] = "Sua inscrição foi efetuada com sucesso! Aguarde pela aprovação." 
				format.html { redirect_to participant_path @participant }
				format.json { render :show, status: :ok, location: @participant }
			else
				format.html { render :new }
				format.json { render json: @participant.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def edit
		@participant = Participant.find_by(id: params[:id], user_id: current_user.id)
		if @participant.nil? 
			redirect_to root_url
		end 
	end

	def update
		@participant = Participant.find_by(id: params[:id], user_id: current_user.id)
		respond_to do |format|
			if @participant.update(participant_params)
				flash[:success] = "Sua inscrição foi efetuada com sucesso! Aguarde pela aprovação." 
				format.html { redirect_to @participant, notice: 'User was successfully updated.' }
				format.json { render :show, status: :ok, location: @participant }
			else
				format.html { render :edit }
				format.json { render json: @participant.errors, status: :unprocessable_entity }
			end

		end
	end

	def show
		begin
			@participant = Participant.find params[:id]
		rescue ActiveRecord::RecordNotFound => e
			flash[:danger] = "Inscrição inexistente!"
			redirect_to participants_path
		end
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
  		flash[:danger] = "Sua conta não permite executar esta ação!"
  		redirect_to root_url
  	end
  end

 # Set Contest
 def set_contest
 	if params.has_key?(:contest_id) && !params[:contest_id].blank?
 		@contest = Contest.find_by(id:params[:contest_id]) 
 	else
 		flash[:danger] = "Concurso inexistente!"
 		redirect_to root_url
 	end
 end

  # Check if user is registered in selected contest current  
  def user_registered
  	@contest = Contest.find_by(id:params[:participant][:contest_id]) 
  	redirect_to contests_path unless !@contest.nil?
  	@user_found = @contest.users.find_by(id:current_user.id)
  	if !@user_found.nil?
  		flash[:danger] = "Você já está inscrito neste concurso!"
      	redirect_to root_url #Redirecionar para o concurso q ele está inscrito
      end
    end

  #Check by  enrollment contest deadline
  def between_deadline
  	if Time.now < @contest.opening_enrollment
  		flash[:info] = "As incriçõs ainda não foram abertas!! Data de abertura: #{@contest.opening_enrollment.strftime("%d/%m/%Y")}"
  		redirect_to root_url
  	elsif Time.now > @contest.closing_enrollment
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

  def participant_params
  	params.require(:participant).permit(:picture, :title, :description, :accepted_term, :contest_id)
  end


end
