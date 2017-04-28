class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :category, null: false      
      t.boolean :is_admin
      t.boolean :is_chat_group
      t.string :chat_group_name
      t.string :note
      

      t.timestamps null: false
    end
  end
end
