class ContestsController < ApplicationController
	
  def list
  	@contests = Contest.list
  end

  def show
  	@contest = Contest.find_by_id(params[:id])
  end

  def archive
  	@contests = Contest.old.paginate(page: params[:page], per_page: 10)
  end
end

