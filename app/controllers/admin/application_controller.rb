class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "admin/layouts/application"

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "Por favor logue para acessar essa pagina"
        redirect_to admin_login_path
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end