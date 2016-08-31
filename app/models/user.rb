class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  # after_create :Admin_initialize

  def self.Admin_initialize
    Rails.logger.info 'Admin Check'
    initial_user = User.where(admin: true)
    if initial_user == []
      Rails.logger.info "Resetting Admin Permissions"
      user = User.find(1)
      user.update(admin: true)
      Log.create :event_code => 10, :table => "Users", :task_length => "00:00:00" , :event => "Admin Reset", :details => "No admin accounts on record, " + user.email + " Set to admin"
    end
  end


  def self.quick_lookup (user_id)
    user = User.find(user_id)
    begin
      characters = EveOnline::Account::Characters.new(user.key_id, user.v_code)
      char_list = []
      char_list.push(
       characters.characters[0].character_name + ' - ' + characters.characters[0].corporation_name,
       characters.characters[1].character_name + ' - ' + characters.characters[1].corporation_name,
       characters.characters[2].character_name + ' - ' + characters.characters[2].corporation_name
       )
    # Rails.logger.info char_list
    return char_list
  rescue
    return ['Character Slot 1', 'Character Slot 2', 'Character Slot 3']
  end
end

  # refactor #1
  def self.validation_task
    Rails.logger.info "Start Validation Task - Refactor 1"
    task_start = Time.now
    user = User.all
    change = false
    # Task Tracker +1
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
            status.concat(' Valid API, Out of Corp primary character')
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
      task_end = Time.now
      task_length = User.time_diff(task_start, task_end)
      if flag != account.valid_api
        change = true
        account.update(valid_api: flag, primary_character_name: character.character_name)
        l = Log.create :event_code => 1, :table => "Users", :task_length => task_length, :event => "Validation Task", :details => "API Change - " + account.email + "/" + account.primary_character_name + " - " + status.to_s
      end
    end

    if change == false
      task_end = Time.now
      task_length = User.time_diff(task_start, task_end)
      l = Log.create :event_code => 0, :table => "Users", :task_length => task_length, :event => "Validation Task", :details => "No changes made"
    end

    User.Admin_initialize
  end

  def self.time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  s = Rufus::Scheduler.singleton

  s.every '15m' do
  	User.validation_task
  end

end
