class ContestsController < ApplicationController

  #before_action :logged_in_user 

  def list
    @current_user = current_user
    @contests = Contest.list#.paginate(page: params[:page], per_page: 10)
  end

  def show
  	@contest = Contest.find_by_id(params[:id])
  end
  
  def archive
  	@contests = Contest.old.paginate(page: params[:page], per_page: 10)
  end

  private

	# Check by user logged
	def logged_in_user
    store_location
    unless user_signed_in?
     flash[:danger] = "Efetue seu login para se inscrever no concurso!"
     redirect_to new_user_session_path
   end
 end

end

