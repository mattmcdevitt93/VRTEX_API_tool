#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#


s.every '30s' do
  Rails.logger.info "Start Validation Task"
  user = User.all
  user.each do |account|
  	if account.key_id != nil and account.v_code != nil
  	  Rails.logger.info "Validating " + account.key_id + "(" + account.v_code + ")"
  	  characters = EveOnline::Account::Characters.new(account.key_id, account.v_code)
      character = characters.characters.first
      Rails.logger.info character.character_name + ":" + character.corporation_name
      if character.corporation_name == "Blitzkrieg."

      	# account.valid_api = true
      	account.update(valid_api: true)
      	Rails.logger.info 'Valid API, in corp'

      end
  	end
  end
end