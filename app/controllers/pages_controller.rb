class PagesController < ApplicationController
  before_action :set_page, only: [:show]
  
  def index
    @pages = Page.all
  end

  def show
  end

  def route
    @page = Page.find_by(permalink: params[:permalink])

    if @page
      render template: 'static_pages/index'
    else
      page_not_found
    end
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:name, :permalink, :content)
    end

    def page_not_found
      head :not_found
    end
end
