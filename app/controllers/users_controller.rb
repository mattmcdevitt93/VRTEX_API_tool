class UsersController < ApplicationController
    before_action :valid_check, only: []
    before_action :admin_check, only: [:index]


	def index
    @user = User.all
    # User.validation_task
	end

  def show
    @stats = 5
    if current_user.admin == true or current_user.id.to_s == params[:id]
      @user = User.find(params[:id])
    else
      redirect_to :root
    end
  end

  def dashboard
    @recent_posts = Post.order(updated_at: :desc).limit(5)
  end

  private

  def user_params
    params.require(:user).permit(:v_code, :email, :password, :password_confirmation, :remember_me)
  end
end