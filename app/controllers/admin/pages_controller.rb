class Admin::PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end
  
  def show
  end
  
  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to [:admin, @page], notice: 'Page was successfully created.'        
    else
      render :new        
    end    
  end
  
  def update    
    if @page.update(page_params)
      redirect_to [:admin, @page], notice: 'Page was successfully updated.'        
    else
      render :edit      
    end    
  end
  
  def destroy
    @page.destroy    
    redirect_to admin_pages_url, notice: 'Page was successfully destroyed.'
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
