require 'discordrb'

class Time
  def prime?
    hour >= 18
  end
end

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
		note = event.message.to_s.downcase.gsub!(/\s+/, '')
		Rails.logger.info "Discord Mention: " + note.to_s
		if note.to_s.blank? or note.include? "help" or note.include? "list" or note.include? "commands"
			event.respond "

Bot Command List: 

Help = This is redundant... you just asked for help.
Time = Tells you the time of all the major time zones (* marks current prime times)

			"
		else

			if note.include? "time"

				zone = ActiveSupport::TimeZone.new("Etc/UTC")
				prime = Time.now.in_time_zone(zone).prime? ? '*' : ''
				event.respond "UTC" + prime + " - " + Time.now.in_time_zone(zone).to_s

				zone = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
				prime = Time.now.in_time_zone(zone).prime? ? '*' : ''
				event.respond "EST" + prime + " - " + Time.now.in_time_zone(zone).to_s

				zone = ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
				prime = Time.now.in_time_zone(zone).prime? ? '*' : ''
				event.respond "PST" + prime + " - " + Time.now.in_time_zone(zone).to_s

				zone = ActiveSupport::TimeZone.new("Australia/Sydney")
				prime = Time.now.in_time_zone(zone).prime? ? '*' : ''
				event.respond "AEST" + prime + " - " + Time.now.in_time_zone(zone).to_s

				zone = ActiveSupport::TimeZone.new("Europe/Moscow")
				prime = Time.now.in_time_zone(zone).prime? ? '*' : ''
				event.respond "MSK" + prime + " - " + Time.now.in_time_zone(zone).to_s
			end

			if note.include? "openthepodbaydoorshal" or note.include? "openthepodbaydoors"
				event.respond "I'm sorry, Dave."
				event.respond "I'm afraid I can't do that."

			end
		end
	end

	$bot.ready do |event|
		$bot.game = "Beta version 0.2"
		# $bot.send_message(ENV["DISCORD_SERVER"], 'Auth-bot is online!', tts = false, embed = nil)
	end

	$bot.run :async
end
