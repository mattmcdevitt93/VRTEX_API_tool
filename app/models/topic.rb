class Topic < ActiveRecord::Base

	def self.forum_groups (id)
		user_groups = Membership.where('user_id' => id, 'approved' => true)
		output = [nil]
		user_groups.each do |group|
      		group_name = Group.find(group.group_id)
      		output = output.push(group_name.id) 
    	end
    	return output
	end

	def self.parent_group_check (id)
		if id != nil
			output = []
			topic = Topic.find(id)
			parent_topic = topic.topic_id
			output.push(topic.group_required)
			x = 0
			until parent_topic == nil || x > 10
				# Rails.logger.info "Parent Check: " + parent_topic.to_s
				parent = Topic.find(parent_topic)
				output.push(parent.group_type)
				parent_topic = parent.topic_id
				x = x + 1
			end
			# Rails.logger.info "== End Parent Check == | " + output.to_s
			return output
		end
	end

end
