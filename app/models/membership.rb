class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	def self.approve_check(status)
  		if status == true
  			status = 'Approved'
  		else
			status = 'Pending'
  		end
  		return status
  end

  def self.admin_approval_check(id, user)
    group = Group.find(id)
    if group.is_admin == true && user.admin == false
      return false
    else
      return true
    end
  end

end
