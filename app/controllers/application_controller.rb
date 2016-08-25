class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  def admin_check
    if current_user.admin === false
      redirect_to :root
    end
  end

  def valid_check
    if current_user.valid_api === false
      redirect_to :root
    end
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:v_code, :key_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:v_code, :key_id, :primary_character, :valid_api, :primary_character_name, :admin, :primary_timezone, :character_cake_day])
  end
end