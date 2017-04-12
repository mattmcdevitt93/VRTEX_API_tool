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
# @Log_file = File.open('log/user_log.txt', 'w+')
# @Log_file.puts (DateTime.now.to_s + " | User Log | Server Start")
# @Log_file.close
$Log_count = 0

require 'uri'