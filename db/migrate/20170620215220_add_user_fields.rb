class AddUserFields < ActiveRecord::Migration
  def change
  	    add_column :users, :corp_ticker, :string
  	    remove_column :timesheets, :event_type
  	    add_column :timesheets, :event_type, :string
  end
end
