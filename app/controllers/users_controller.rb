class UsersController < ApplicationController
    before_action :valid_check, only: []
    before_action :admin_check, only: [:index]
    before_action :director_check, only: [:stats]

	def index
    @user = User.paginate(:page => params[:page], :per_page => 50).order(id: :desc)
    @blacklist = Blacklist.new
	end

  def stats
    @user = User.where('corp_ticker' => current_user.corp_ticker).order(id: :desc)
    if current_user.admin == true && params[:user_index] == 'true'
      @user = User.all.order(id: :desc)
    end
  end
  
  def show
    @stats = 5
    @memberships = Membership.where('user_id' => params[:id], 'approved' => true) 
    if current_user.admin == true or current_user.id.to_s == params[:id]
      @user = User.find(params[:id])
    else
      redirect_to :root
    end
  end

  def dashboard

  end

  private

  def user_params
    params.require(:user).permit(:v_code, :discord_user_id, :email, :password, :password_confirmation, :remember_me)
  end
end