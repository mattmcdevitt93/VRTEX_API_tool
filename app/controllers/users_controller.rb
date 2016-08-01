class UsersController < ApplicationController

	def index
    @user = User.all

      # job_id = Rufus::Scheduler.singleton.in '5s' do
      #   Rails.logger.info "time flies, it's now #{Time.now}"
      # end

      # key_id = 5475150
      # v_code = 'M8Xx3MwZmilaHKVMvk3gEGWZHQt3RHoxR2K2exB1w3cTNn2bX9emuUtBZLwFnhSn'
      
      # characters = EveOnline::Account::Characters.new(key_id, v_code)
      # character = characters.characters.first
      # @char = character.character_name
      # @corp = character.corporation_name

	end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:v_code, :email, :password, :password_confirmation, :remember_me)
  end
end