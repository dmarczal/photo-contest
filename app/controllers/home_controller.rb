class HomeController < ApplicationController
  def index
  	@current_contest = Contest.current
	@old_contests = Contest.closed_home
  	#@oldContests = Contest.all
  end
end
