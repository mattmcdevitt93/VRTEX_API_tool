class RegistrationsController < Devise::RegistrationsController 

  def edit

  end

  def update
    @data = params[:user][:v_code]
    # Rails.logger.info 'Update Check: ' + @data.to_s
    @data = User.encrypt(@data)
    params[:user][:v_code] = @data
        # Rails.logger.info 'Update Check: ' + @data.to_s

    @user = User.where('email' => params[:user][:email].to_s)

    Rails.logger.info "=================================="
    Rails.logger.info "API check: " + params[:user][:email].to_s
    Rails.logger.info "=================================="
    Rails.logger.info @user.to_s
    User.validation_check(@user, "Individual")

    super
  end
end