class ToolboxController < ApplicationController

	def log_index
		@logs = Log.paginate(:page => params[:page], :per_page => 25).order(created_at: :desc)
	end

end