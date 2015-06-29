class Admin::ParticipantsController < ApplicationController

  def update
    @participant = Participant.find(params[:id])
    @participant.approved = params[:approved]
    respond_to do |format| 
        if @participant.save 
          format.js {render inline: "location.reload();" }
        else 
          format.js { render json: @participant.errors, status: :unprocessable_entity }
        end 
    end 
  end
end
