class HomeController < ApplicationController
  def index
  	@currentContest = Contest.current
	@oldContests = Contest.closed_home
  	#@oldContests = Contest.all
  end
end
