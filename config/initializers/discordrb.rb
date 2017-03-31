require 'discordrb'
# Auth link
# https://discordapp.com/oauth2/authorize?&client_id=297109346566012928&scope=bot&permissions=335546430

$discord_server_id = 'Mjk3MTA5MzQ2NTY2MDEyOTI4.C78w2g.5dg9TNdYD8VyMGYqBm4YvHMsXKU'

bot = Discordrb::Bot.new token: $discord_server_id, client_id: 297109346566012928

# bot.message(with_text: 'Ping!') do |event|
#   event.respond 'Pong!'
# end

# bot.run