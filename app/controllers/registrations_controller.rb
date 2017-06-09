class RegistrationsController < Devise::RegistrationsController 

  def edit

  end

  def update
    @data = params[:user][:v_code]
    # Rails.logger.info 'Update Check: ' + @data.to_s
    @data = User.encrypt(@data)
    params[:user][:v_code] = @data
        # Rails.logger.info 'Update Check: ' + @data.to_s
    super
  end
end