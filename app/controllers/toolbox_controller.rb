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

		if params[:start_task] == 'true' and current_user.admin == true
			User.validation_task ('Manual')
		end

		if params[:toggle_validation] == 'true' and current_user.admin == true
			Log.create :event_code => 0, :table => "Admin", :task_length => "00:00:00", :event => "Managment Task", :details => "API validation was turned to " + $SETTING_REQUIRE_API.to_s + " By " + current_user.email

			Rails.logger.info "Toggle_Validation:" + $SETTING_REQUIRE_API.to_s
			$SETTING_REQUIRE_API = !$SETTING_REQUIRE_API
		end



	end

	private

	def contact_params
		params.require(:contact).permit(:name, :standing, :notes, :expire?)
	end

end