class UsersController < ApplicationController

	def index
    @user = User.all
    # User.validation_task
	end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    if params[:start_task] == 'true'
      User.validation_task
    end
  end

  private

  def user_params
    params.require(:user).permit(:v_code, :email, :password, :password_confirmation, :remember_me)
  end
end