class Toolbox < ActiveRecord::Base

	def self.env_var_check 
		if ENV["DISCORD_SERVER"] != nil && ENV["DISCORD_CLIENT"] != nil && ENV["DISCORD_TOKEN"] != nil
			return true
		else
			return false
		end
	end

	def self.discord_check (bot)
		if Toolbox.env_var_check() == false
			Rails.logger.info "discord_check - ENV failure"
			return
		end
		target_users = User.where.not(discord_user_id: [nil, ""])
		Rails.logger.info "discord_check - check users - " + target_users.to_s
		target_users.each do |target|
			# Rails.logger.info "target - " + target.primary_character_name.to_s + " | " + target.discord_user_id
			if target.valid_api == true
				Toolbox.discord_add_roles(bot, target, "Member")
			else
				Toolbox.discord_clear_roles(bot, target.discord_user_id)
			end
		end
		# bot.send_message(ENV["DISCORD_SERVER"], 'Discord Bot Action from server - Model Check', tts = false, embed = nil)
		# Toolbox.discord_clear_roles(bot, user_id)
		# discord_user_id
	end

	def self.discord_add_roles (bot, user_id, role_name)
		if Toolbox.env_var_check() == false
			Rails.logger.info "discord_check - ENV failure"
			return
		end
		Rails.logger.info user_id.primary_character_name.to_s + ": Valid API - Activate Discord - " + user_id.discord_user_id.to_s
		server = bot.servers[ENV["DISCORD_SERVER"].to_i]
		role_to_add = server.roles.find {|role| role.name == role_name}
		# Rails.logger.info "Server members - " + server.members.to_s
		member = server.members.find {|user| user.id == user_id.discord_user_id.to_i}
		# Rails.logger.info "active member - " + member.to_s
		member.add_role(role_to_add)
	end

	def self.discord_clear_roles (bot, user_id)
		if Toolbox.env_var_check() == false
			Rails.logger.info "discord_check - ENV failure"
			return
		end
		user = bot.servers[ENV["DISCORD_SERVER"].to_i].members.find {|s| s.id == user_id.to_i}
		user.remove_role(user.roles)
		Rails.logger.info "target - clear all roles - " + user.name.to_s
		# bot.send_message(ENV["DISCORD_SERVER"], 'Discord Bot Action clear all roles of ' + user.name.to_s, tts = false, embed = nil)
	end
end
