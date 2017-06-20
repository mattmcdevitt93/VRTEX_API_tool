# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

$server_id = Random.new.rand(1000000..1999999)
# API Validation - All accounts have access if FALSE
$SETTING_REQUIRE_API = true

# Commented out file logging
$Log_count = 0

# Discord bot setting
if ENV["DISCORD_SERVER"] != nil && ENV["DISCORD_CLIENT"] != nil && ENV["DISCORD_TOKEN"] != nil
	$Discord_bot_active = true
else
	$Discord_bot_active = false
end

$Discord_name_overwrite = true
require 'open-uri'

require 'uri'