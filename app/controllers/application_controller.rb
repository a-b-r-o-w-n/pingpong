class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  add_flash_types :danger, :warning, :info, :success
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def object_errors_flash( object )
    object.errors.full_messages.join('<br>').html_safe
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :new_password]
  end

end
