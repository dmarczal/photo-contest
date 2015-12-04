class VotesController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :voted_already, only: :create

  def create
    vote = Vote.new(user_id: current_user.id, participant_id: @participant.id)

    respond_to do |format|
      if vote.save
        #format.html { redirect_to @contest, notice: 'Voto registrado. Você pode votar uma única vez em cada concurso.' }
        format.json { head :no_content }
        format.js {render inline: "location.reload();" }
        flash[:success] = 'Voto registrado. Você pode votar uma única vez em cada concurso.'
      else
        flash[:danger] = 'Problemas no registro do voto.'
        #format.html { redirect_to @contest, notice: 'Problemas no registro do voto.' }
        format.json { render json: vote.errors, status: :unprocessable_entity }
        format.js { render json: vote.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def voted_already
    @participant = Participant.find_by(id: params[:id])
    @contest = Contest.find_by(id: @participant.contest_id)

    contest_participants = Participant.where(contest_id: @contest.id).pluck(:id)
    user_votes = Vote.where(participant_id: contest_participants, user_id: current_user.id)

    unless user_votes.empty?
      flash[:danger] = 'Você já votou neste concurso.'
      redirect_to @contest
    end
  end

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "Efetue seu login para votar no concurso!"
      redirect_to new_user_session_path
    end
  end
end