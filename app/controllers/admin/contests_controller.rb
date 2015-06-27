class Admin::ContestsController < Admin::ApplicationController
  before_action :logged_in_user
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

  def index
    @contests = Contest.all
  end

  def show
  end

  def new
    @contest = Contest.new
  end

  def edit
  end

  def create
    @contest = Contest.new(contest_params)

    if @contest.save
      redirect_to admin_contest_path(@contest), notice: 'Contest was successfully created.'
    else
      render :new
    end
  end

  def update
    if @contest.update(contest_params)
      redirect_to admin_contest_path(@contest), notice: 'Contest was successfully updated.'
    else
      render :edit
      render json: @contest.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contest.destroy
    redirect_to admin_contests_url, notice: 'Contest was successfully destroyed.'
  end

  def contest_inscriptions
    @inscriptions = Participant.all.where("contest_id = ?", params[:contest_id])
    if @inscriptions.count == 0 
      flash[:info] = "Ainda não existem inscrições para este concurso"  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
      @inscriptions = contest_inscriptions
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:title, :description, :image, :opening_enrollment, :closing_enrollment, :opening, :closing)
    end
end
