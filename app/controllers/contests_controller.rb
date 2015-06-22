class ContestsController < ApplicationController
  def list
  end

  def show
  end

  def archive
  	@contests = Contest.old.paginate(page: params[:page], per_page: 10)
  end
end
