class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.boolean :approved, null: false
      t.boolean :is_chat_group
      t.string :chat_group_name


      t.timestamps null: false
    end
  end
end
