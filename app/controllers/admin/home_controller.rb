class Admin::HomeController < Admin::ApplicationController
  #Create Action beforeAction
  #  if user_signed_in? && current_user.admin?
  before_action :logged_in_user
  #before_action :correct_user
  before_action :admin_user

  def index
    @contests =  Contest.opening_enrollment
    @not_approved_participants = Participant.pending.where(contest_id: @contests.ids)
    @contests_opening = Contest.opening
  end


end
