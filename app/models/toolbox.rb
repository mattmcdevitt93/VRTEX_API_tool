class Toolbox < ActiveRecord::Base

	def self.env_var_check 
		if ENV["DISCORD_SERVER"] != nil && ENV["DISCORD_CLIENT"] != nil && ENV["DISCORD_TOKEN"] != nil && $Discord_bot_active == true
			return true
		else
			return false
		end
	end

	def self.discord_check (bot)
		Rails.logger.info "--++++++++++++++++++++++++++++++--"
		Rails.logger.info "-- Begin Discord Group Updates  --"
		Rails.logger.info "--++++++++++++++++++++++++++++++--"

		if Toolbox.env_var_check() == false
			Rails.logger.info "discord_check - ENV failure"
			return
		end
		target_users = User.where.not(discord_user_id: [nil, ""])
		Rails.logger.info "discord_check - check users - " + target_users.to_s
		server = bot.servers[ENV["DISCORD_SERVER"].to_i]

		target_users.each do |target|
			# Rails.logger.info "target - " + target.primary_character_name.to_s + " | " + target.discord_user_id
			if target.valid_api == true
					begin
					server_user = server.members.find {|user| user.id == target.discord_user_id.to_i}
					active_roles = server_user.roles
					rescue
					Rails.logger.info "Role Check error"
					active_roles = []
					end

					user_chat_groups = User.get_chat_groups(target.id)
					Rails.logger.info "User Chat Groups: " + user_chat_groups.to_s + " (" +  user_chat_groups.length.to_s + " | " + active_roles.length.to_s + ")"
					
					if user_chat_groups.length != active_roles.length
						Toolbox.discord_clear_roles(bot, target.discord_user_id)
					end

					user_chat_groups.each do |chat_group|
						begin
							Toolbox.discord_add_roles(bot, target, chat_group.to_s, server)
						rescue
							Rails.logger.info "Discord_check - Role Error"
						end
					end

					if $Discord_name_overwrite == true
						Toolbox.discord_name_check(bot, target)
					end
			else
				Toolbox.discord_clear_roles(bot, target.discord_user_id)
			end
			sleep 1
			Rails.logger.info "===++++++++++++++++++++++++++++==="
		end
		# bot.send_message(ENV["DISCORD_SERVER"], 'Discord Bot Action from server - Model Check', tts = false, embed = nil)
		# Toolbox.discord_clear_roles(bot, user_id)
		# discord_user_id
			Rails.logger.info "===    End of Discord Bot      ==="
			Rails.logger.info "===++++++++++++++++++++++++++++==="
	end

	def self.discord_name_check (bot, user_id)
		user = bot.servers[ENV["DISCORD_SERVER"].to_i].members.find {|s| s.id == user_id.discord_user_id.to_i}
		user_nickname = user.nickname.to_s
		if user_id.corp_ticker != nil
			ticker = "[" + user_id.corp_ticker + "] "
		else
			ticker = ""
		end
		current_name = ticker.to_s + user_id.primary_character_name.to_s
		Rails.logger.info "Auth Username: " + current_name.to_s + " | Discord name: " + user_nickname.to_s
		if current_name.to_s == user_nickname.to_s
			Rails.logger.info "Discord Name Correct"
		else
			Rails.logger.info "Overwrite Discord Name"
			begin
			user.nickname = current_name
			rescue
			Rails.logger.info "Permission Error: Discord Name"
			end
		end
	end

	def self.discord_add_roles (bot, user_id, role_name, server)
		if Toolbox.env_var_check() == false
			Rails.logger.info "discord_check - ENV failure"
			return
		end
		begin
		Rails.logger.info user_id.primary_character_name.to_s + ": Valid API - Activate Discord - " + user_id.discord_user_id.to_s
		role_to_add = server.roles.find {|role| role.name == role_name}
		# Rails.logger.info "Server members - " + server.members.to_s
		user = server.members.find {|user| user.id == user_id.discord_user_id.to_i}
		user_roles = user.roles.find {|role| role.name == role_name}
			if user_roles == nil
			Rails.logger.info "Added Role to member - " + user.name.to_s + " | " + role_name.to_s
			user.add_role(role_to_add)
			end
		rescue
			Rails.logger.info "target - add all roles - Error"
		end
	end

	def self.discord_clear_roles (bot, user_id)
		if Toolbox.env_var_check() == false
			Rails.logger.info "discord_check - ENV failure"
			return
		end
		begin
		user = bot.servers[ENV["DISCORD_SERVER"].to_i].members.find {|s| s.id == user_id.to_i}
		user.remove_role(user.roles)
		Rails.logger.info "target - clear all roles - " + user.name.to_s
		rescue
			Rails.logger.info "target - clear all roles - Error"
		end
		# bot.send_message(ENV["DISCORD_SERVER"], 'Discord Bot Action clear all roles of ' + user.name.to_s, tts = false, embed = nil)
	end
end
