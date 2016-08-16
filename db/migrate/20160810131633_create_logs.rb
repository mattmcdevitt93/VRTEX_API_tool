class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :table
      t.string :event
      t.string :details
      t.string :task_length
      t.integer :event_code

      t.timestamps null: false
    end
  end
end
