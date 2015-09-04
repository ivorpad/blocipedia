class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    wikis_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to ( request.referrer || root_path )
  end

end
