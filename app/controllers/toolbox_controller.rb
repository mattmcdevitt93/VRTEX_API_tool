class ToolboxController < ApplicationController
	  before_action :admin_check, only: [:log_index, :log_index_events]


	def log_index
		@logs = Log.paginate(:page => params[:page], :per_page => 50).order(created_at: :desc)
	end

	def log_index_events
		@logs = Log.where("event_code != 0").paginate(:page => params[:page], :per_page => 50).order(created_at: :desc)
	end

end