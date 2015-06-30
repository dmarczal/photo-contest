class VotesController < ApplicationController

def create
  @participant = Participant.find_by(id: params[:id])
  @vote = Vote.new(user_id: current_user.id, participant_id: @participant.id)
  
  respond_to do |format|
    if @vote.save
      flash[:success] = "Voto registrado. Você pode votar uma única vez em cada concurso" 
      format.js {render inline: "location.reload();" }
    else
      flash[:error] = "Problemas com o voto" 
      format.js { render json: @vote.errors, status: :unprocessable_entity }
    end
  end
end

end
