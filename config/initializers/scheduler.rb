#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#

# Awesome recurrent task...

      # job_id = Rufus::Scheduler.singleton.in '5s' do
      #   Rails.logger.info "time flies, it's now #{Time.now}"
      # end

      # key_id = 5475150
      # v_code = 'M8Xx3MwZmilaHKVMvk3gEGWZHQt3RHoxR2K2exB1w3cTNn2bX9emuUtBZLwFnhSn'
      
      # characters = EveOnline::Account::Characters.new(key_id, v_code)
      # character = characters.characters.first
      # @char = character.character_name
      # @corp = character.corporation_name

  $s = Rufus::Scheduler.singleton