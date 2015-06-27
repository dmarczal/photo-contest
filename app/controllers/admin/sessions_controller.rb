class Admin::SessionsController < Admin::ApplicationController

  layout "admin/layouts/login"

  def new
  end

  def create
    @user = User.find_for_database_authentication(login: params[:session][:login])

    if @user && @user.valid_password?(params[:session][:password]) && @user.admin?
      flash[:success] = 'Seja bem-vindo a área administrativa'
      sign_in(:user, @user)
      redirect_to admin_root_path
    else
      flash.now[:danger] = 'Login/senha incorretos'
      render :new
    end
  end

  def destroy
    sign_out current_user
    redirect_to admin_login_path
  end
end

