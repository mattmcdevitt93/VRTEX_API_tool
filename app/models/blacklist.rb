class Blacklist < ActiveRecord::Base
	belongs_to :user

	def self.Tag_check(status)
		# Rails.logger.info "Status request: " + status.to_s
		if status == 0 
			tag_status = 'Other'
		elsif status == 1
			tag_status = 'Spai'
		elsif status == 2
			tag_status = 'Corp Hopping'
		elsif status == 3
			tag_status = 'Denied Appliction'
		end
		return tag_status
  	end

	def self.Type_check(status)
		Rails.logger.info "Status request: " + status.to_s
  		if status == true
  			status = 'Main'
  		else
			status = 'Alt'
  		end
  		return status
  	end

end
