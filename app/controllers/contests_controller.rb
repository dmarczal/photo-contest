class ContestsController < ApplicationController
  def list
  end

  def show
  end

  def archive
  	@contest_old = Contest.old
  end
end
