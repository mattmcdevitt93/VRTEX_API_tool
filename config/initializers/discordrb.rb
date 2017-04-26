require 'discordrb'

if ENV["DISCORD_SERVER"] != nil && ENV["DISCORD_CLIENT"] != nil && ENV["DISCORD_TOKEN"] != nil

	$bot = Discordrb::Commands::CommandBot.new token: ENV["DISCORD_TOKEN"], client_id: ENV["DISCORD_CLIENT"]
	# $bot.message(with_text: 'Ping!') do |event|
	# 	user = event.user
	# 	member = user.on(ENV["DISCORD_SERVER"])
	# 	server = member.server
	# 	Rails.logger.info "--------------------------"
	# 	Rails.logger.info member.server.roles.to_s
	# 	Rails.logger.info "--------------------------"
	# 	role = member.server.roles.find {|role| role.name == 'Member'}
	# 	server.members.each do |user|
	# 		Rails.logger.info user.username.to_s
	# 	end

	# 	member.add_role(role)
	# 	event.respond 'Pong! Hello ' + user.name.to_s
	# end

	# $bot.message(with_text: 'Pong!') do |event|
	# 	user = event.user
	# 	member = user.on(ENV["DISCORD_SERVER"])
	# 	# server = member.server
	# 	# Rails.logger.info "--------------------------"
	# 	# Rails.logger.info member.server.roles.to_s
	# 	# Rails.logger.info "--------------------------"
	# 	role = member.server.roles.find {|role| role.name == 'Member'}
	# 	Rails.logger.info role.id.to_s
	# 	member.remove_role(role)
	# 	event.respond 'Ping! Hello ' + user.name.to_s
	# end


	$bot.mention() do |event|
		event.respond Time.now.to_s
	end

	$bot.ready do |event|
		$bot.game = "Work In Progress"
		$bot.send_message(ENV["DISCORD_SERVER"], 'VRTEX-bot is online!... Sorta', tts = false, embed = nil)
	end

	$bot.run :async
end
