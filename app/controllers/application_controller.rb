class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_static_pages

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :name, :short_description, :biography, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  #redirect user to storage location after sign in
  def after_sign_in_path_for(resource)
    session[:forwarding_url] || root_path
  end

  def set_static_pages
    ids = Page.where("permalink = ? OR permalink = ?",  'about', 'contact').pluck(:id)
    @static_pages = Page.where('id NOT IN (:ids)', ids: ids).order(:name)
  end
end
