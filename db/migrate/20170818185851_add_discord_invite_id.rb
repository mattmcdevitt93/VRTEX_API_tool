class AddDiscordInviteId < ActiveRecord::Migration
  def change
  	add_column :users, :discord_invite, :string
  	add_column :users, :discord_connected, :boolean
  end
end
