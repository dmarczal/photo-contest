class Admin::ParticipantsController < ApplicationController

  def update
    @participant = Participant.find(params[:id])
    @participant.status = params[:status]
    respond_to do |format| 
        if @participant.save 
          format.js {render inline: "location.reload();" }
        else 
          puts @participant.errors
          format.js { render json: @participant.errors, status: :unprocessable_entity }
        end 
    end 
  end
end
