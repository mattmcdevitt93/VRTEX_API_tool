class AddColumn < ActiveRecord::Migration
  def change
    add_column :groups, :is_hidden, :boolean
  end
end
