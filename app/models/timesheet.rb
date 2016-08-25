class Timesheet < ActiveRecord::Base

	def self.urgency_id (rank)
		if rank == 0 
			notification = 'None'
		elsif rank == 1
			notification = 'Offensive - Low Priority - Bash time...'
		elsif rank == 2
			notification = 'Offensive - Medium Priority - Alliance Objectives'
		elsif rank == 3
			notification = 'Offensive - High Priority - Strategic Operation'
		elsif rank == 4
			notification = 'Defence - Low Priority - Possible Timer Punt'
		elsif rank == 5
			notification = 'Defence - High Priority - There will be a fight'
		elsif rank == 6
			notification = 'Defence - Ultra Hig Priority - Bat phone'
		end
		return notification
	end


	def self.type_id (rank)
		if rank == 0 
			notification = 'None'
		elsif rank == 1
			notification = 'Teritory Claim Unit'
		elsif rank == 2
			notification = 'Infastructure Hub'
		elsif rank == 3
			notification = 'Outpost'
		elsif rank == 4
			notification = 'Player Owned Station'
		elsif rank == 5
			notification = 'Strategic Operation'
		elsif rank == 6 
			notification = 'Other'
		end
		return notification
	end
end
