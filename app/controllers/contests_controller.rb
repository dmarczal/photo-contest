class ContestsController < ApplicationController
  def list
  	@open = Contest.list
  end

  def show
  end

  def archive
  end
end
