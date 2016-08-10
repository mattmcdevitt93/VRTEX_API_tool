class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable


  def self.quick_lookup (user_id)
    user = User.find(user_id)
    characters = EveOnline::Account::Characters.new(user.key_id, user.v_code)
    char_list = []
    char_list.push(
       characters.characters[0].character_name + ' - ' + characters.characters[0].corporation_name,
       characters.characters[1].character_name + ' - ' + characters.characters[1].corporation_name,
       characters.characters[2].character_name + ' - ' + characters.characters[2].corporation_name
      )
    # Rails.logger.info char_list
    return char_list
  end

    def self.validation_task
    Rails.logger.info "Start Validation Task - Refactor 1"
    user = User.all
    user.each do |account|
      flag = nil
      status = ''
      if (account.key_id.to_s.length == 7) and (account.v_code != nil or account.v_code != "")
        characters = EveOnline::Account::Characters.new(account.key_id, account.v_code)
        begin
          character = characters.characters[account.primary_character]
            if character.corporation_name == "Blitzkrieg."
              status.concat(' Valid API, Accepted')
              flag = true
            else 
              status.concat(' Valid API, Out of Corp')
              flag = false
            end
        rescue
          status.concat(' No Primary Character Selected')
          flag = false
          character = nil
        end
      else
        status.concat(' Invalid Valid API code')
        flag = false
      end
      Rails.logger.info account.email + " - " +  flag.to_s + "/" + account.valid_api.to_s + " - " + status.to_s
      if flag != account.valid_api
        account.update(valid_api: flag)
      end
    end
  end

  # Old Version
  # def self.validation_task
  #   Rails.logger.info "Start Validation Task"
  #   user = User.all
  #   user.each do |account|
  #     if (account.key_id.to_s.length == 7) and (account.v_code != nil or account.v_code != "")
  #       Rails.logger.info "Validating " + account.key_id + "(" + account.v_code + ")"
  #       characters = EveOnline::Account::Characters.new(account.key_id, account.v_code)
  #       Rails.logger.info characters.inspect
  #       begin
  #         character = characters.characters[account.primary_character]
  #         Rails.logger.info character.character_name + ":" + character.corporation_name
  #         if character.corporation_name == "Blitzkrieg."
  #           account.update(valid_api: true)
  #           Rails.logger.info 'Valid API, in corp'
  #         else 
  #           Rails.logger.info 'Valid API, Out of Corp'
  #           account.update(valid_api: false)
  #         end
  #       rescue
  #         Rails.logger.info 'Bad API'
  #         account.update(valid_api: false)
  #       end
  #     else
  #       Rails.logger.info 'Invalid Valid API'
  #       account.update(valid_api: false)
  #     end
  #   end
  # end

  s = Rufus::Scheduler.singleton

  s.every '15m' do
  	validation_task
  end

end
