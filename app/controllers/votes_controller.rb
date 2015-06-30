class VotesController < ApplicationController
  before_action :logged_in_user, only: :create

  def create
    participant = Participant.find_by(id: params[:id])
    vote = Vote.new(user_id: current_user.id, participant_id: participant.id)
    
    if not_voted_in_this_contest(participant.id)
      respond_to do |format|
        if vote.save
          flash[:success] = "Voto registrado. Você pode votar uma única vez em cada concurso" 
          format.js {render inline: "location.reload();" }
        else
          flash[:danger] = "Problemas com o voto" 
          format.js { render json: vote.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:danger] = "Você já votou em uma inscrição deste concurso"
    end
  end

  private

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "Efetue seu login para se votar no concurso!"
      redirect_to new_user_session_path
    end
  end
end