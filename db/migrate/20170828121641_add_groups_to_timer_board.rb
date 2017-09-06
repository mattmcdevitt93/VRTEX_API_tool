class AddGroupsToTimerBoard < ActiveRecord::Migration
  def change
  	add_column :timesheets, :event_group, :integer
  	add_column :timesheets, :broadcast, :boolean
  end
end
