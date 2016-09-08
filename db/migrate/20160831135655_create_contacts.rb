class CreateContacts < ActiveRecord::Migration
  def change
  	  create_table :contacts do |t|
      t.string :name, null: false
      t.integer :standing, null: false
      t.datetime :expire?
      t.string :notes

      t.timestamps null: false
  	end
  end
end
