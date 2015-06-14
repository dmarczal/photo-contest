class HomeController < ApplicationController
  def index
  	@currentContest = Contest.last
  	@oldContests = Contest.last(3)
	# @contests = Contest.where(":opening_enrollment < ?", Time.zone.now)
  end
end
