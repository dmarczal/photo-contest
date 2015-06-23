class Admin::HomeController < Admin::ApplicationController
  #Create Action beforeAction
  #  if user_signed_in? && current_user.admin?
  before_action :logged_in_user
  #before_action :correct_user
  before_action :admin_user

  def index
  end

end
