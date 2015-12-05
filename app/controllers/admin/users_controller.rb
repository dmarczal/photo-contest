class Admin::UsersController < Admin::ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end
end
