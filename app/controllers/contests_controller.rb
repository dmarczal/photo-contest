class ContestsController < ApplicationController
  def list
  	@contests = Contest.list
  end

  def show
  end

  def archive
  	@contest_old = Contest.old
  end
end
