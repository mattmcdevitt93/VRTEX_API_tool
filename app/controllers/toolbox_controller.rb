class ToolboxController < ApplicationController
	before_action :admin_check, only: [:log_index, :log_index_events, :dashboard]


	def log_index
		@logs = Log.paginate(:page => params[:page], :per_page => 50).order(created_at: :desc)
	end

	def log_index_events
		@logs = Log.where("event_code != 0").paginate(:page => params[:page], :per_page => 50).order(created_at: :desc)
	end

	def log_file

	end

	def dev_notes

	end

	def admin_dashboard
		@contacts = Contact.all.order(standing: :desc)
		@contact = Contact.new
		@env_check = Toolbox.env_var_check()

		if params[:start_task] == 'true' and current_user.admin == true
			User.validation_task ('Manual')
			redirect_to admin_dashboard_path
		end

		if params[:toggle_validation] == 'true' and current_user.admin == true
			Log.create :event_code => 0, :table => "Admin", :task_length => "00:00:00", :event => "Managment Task", :details => "API validation was turned to " + $SETTING_REQUIRE_API.to_s + " By " + current_user.email

			Rails.logger.info "Toggle_Validation:" + $SETTING_REQUIRE_API.to_s
			$SETTING_REQUIRE_API = !$SETTING_REQUIRE_API
			redirect_to admin_dashboard_path
		end

		if params[:clear_logs] == 'true' and current_user.admin == true
			Rails.logger.info "Clear All DB Logs:"
			@log_dump = Log.all
			@Log_file = File.open('log/user_log_' + Time.now.to_s + '.txt', 'w+')
			@log_dump.each do |log|
				Rails.logger.info "Move Row ID:" + log.id.to_s + " to file."
				@Log_file.write(log.updated_at.to_s + " : " + log.task_length.to_s + " (" + log.event_code.to_s + ") " + log.details.to_s + "\n")
			end
			@Log_file.close
			Log.delete_all
			Log.create :event_code => 0, :table => "Admin", :task_length => "00:00:00", :event => "All Logs cleared", :details => "Old contents moved to Log File"
			redirect_to admin_dashboard_path
		end

		if params[:discord_check] == 'true' and current_user.admin == true
			Log.create :event_code => 0, :table => "Admin", :task_length => "00:00:00", :event => "Managment Task", :details => "Discord Check"
			Toolbox.discord_check($bot)
			redirect_to admin_dashboard_path
		end

		if params[:full_user_check] == 'true' and current_user.admin == true
			User.validation_task ('Manual')
			Toolbox.discord_check($bot)
			redirect_to admin_dashboard_path
		end


		if params[:discord_active] == 'true' and current_user.admin == true
    		Rails.logger.info "toggle Discord Bot"
    		$Discord_bot_active = !$Discord_bot_active
    		redirect_to admin_dashboard_path
   		end


	end

	private

	def contact_params
		params.require(:contact).permit(:name, :standing, :notes, :expire?)
	end

end