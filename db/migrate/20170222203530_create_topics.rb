class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id, null: false
      t.integer :topic_id
      t.string :title, null: false
      t.string :description
      t.boolean :group_required
      t.integer :group_type
      t.boolean :allow_topics
      t.boolean :allow_posts
      t.integer :rank
      t.boolean :active

      t.timestamps null: false
    end
  end
end
