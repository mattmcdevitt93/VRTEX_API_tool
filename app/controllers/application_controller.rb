class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:v_code, :key_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:v_code, :key_id, :primary_character, :valid_api])
  end
end