class RankingController < ApplicationController
  def index
    @users = User.all
    @users_ordened = @users.order(first: :desc, second: :desc, third: :desc)
    @participants = @users_ordened.paginate(page: params[:page], per_page: 10)
  end

end
