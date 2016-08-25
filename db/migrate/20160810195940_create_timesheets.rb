class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.string :event
      t.datetime :event_time
      t.integer :event_type
      t.integer :user_id
      t.integer :urgency
      t.string :notes

      t.timestamps null: false
    end
  end
end
