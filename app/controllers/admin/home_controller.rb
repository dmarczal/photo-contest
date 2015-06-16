class Admin::HomeController < Admin::ApplicationController
  #Create Action beforeAction
  #  if user_signed_in? && current_user.admin?
  before_action :logged_in_user
  #before_action :correct_user
  before_action :admin_user

  def index
  end

  private
   # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "Por favor, insira seu login!"
        redirect_to admin_login_path
      end
    end

    # Confirms the correct user.
    #def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to(login_url) unless current_user?(@user)
    #end

     # Confirms an admin user.
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
