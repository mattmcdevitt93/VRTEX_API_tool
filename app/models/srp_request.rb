class SrpRequest < ActiveRecord::Base

	def self.Status_check(status)
		# Rails.logger.info "Status request: " + status.to_s
		if status == 0 
			request_status = 'Submitted'
		elsif status == 1
			request_status = 'Accepted'
		elsif status == 2
			request_status = 'Processing'
		elsif status == 3
			request_status = 'Denied'
		end
		return request_status
  	end

  	def self.SRP_action(action)
  		Rails.logger.info "SRP Action - " + action.to_s
  	end
end
