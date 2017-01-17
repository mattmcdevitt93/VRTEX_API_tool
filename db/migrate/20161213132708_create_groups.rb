class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :category, null: false      
      t.integer :level
      t.string :note
      

      t.timestamps null: false
    end
  end
end
