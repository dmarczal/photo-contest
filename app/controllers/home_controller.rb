class HomeController < ApplicationController
  def index
  	@current_contest = Contest.current
    @old_contests = Contest.closed_home
    @participants = Participant.where(status: 2).order(created_at: :desc).limit(10)

  end
end
