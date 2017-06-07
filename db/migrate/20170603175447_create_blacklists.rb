class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.string :Player_name
      t.boolean :character_type
      t.integer :tag
      t.string :reason
      t.integer :reporter_id

      t.timestamps null: false
    end
    add_column :users, :director, :boolean, default: false
    add_column :groups, :is_director, :boolean
  end
end
