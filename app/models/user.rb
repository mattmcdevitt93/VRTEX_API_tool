class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :groups, :through => :memberships

  def self.encrypt (var)
    if var === nil
      return nil
    end
    key = ENV["VCODEKEY"]
    encrypted_data = AES.encrypt(var, key)
    return encrypted_data
  end

  def self.decrypt (var)
    if var === nil
      return nil
    end
    key = ENV["VCODEKEY"]
    encrypted_data = AES.decrypt(var, key)
    return encrypted_data
  end

  def self.get_groups (id)
    Rails.logger.info 'Group Check'
    user_groups = Membership.where('user_id' => id, 'approved' => true)
    output = ""
    user_groups.each do |group|
      group_name = Group.find(group.group_id)
      output = output + "[" + group_name.name.to_s + "] "
    end
    return output
  end

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

  def self.Admin_check_groups (user)
    groups = Membership.where('user_id' => user, 'approved' => true)
    update = false
    groups.each do |group|
      group_name = Group.find(group.group_id)
      # Rails.logger.info group_name.name.to_s + ' | ' + group_name.is_admin.to_s
      if group_name.is_admin === true
        update = true
      end
    end
    user_id = User.find(user)
    if update === true
      user_id.update(admin: true)
    else
      user_id.update(admin: false)
    end
    Rails.logger.info 'Admin Group Check - ' + user.to_s + ' | User is admin? ' + update.to_s
  end

  def self.quick_lookup (user_id, option)
    user = User.find(user_id)
    begin
      characters = EveOnline::Account::Characters.new(user.key_id, User.decrypt(user.v_code))
      char_list = []
      char_list.push(
       characters.characters[0].character_name + ' - ' + characters.characters[0].corporation_name,
       characters.characters[1].character_name + ' - ' + characters.characters[1].corporation_name,
       characters.characters[2].character_name + ' - ' + characters.characters[2].corporation_name
       )
    # Rails.logger.info char_list
    if option == 1
      char = char_list[user.primary_character]
      return char
    else 
      return char_list
    end

    rescue
      return ['Character Slot 1', 'Character Slot 2', 'Character Slot 3']
    end
  end

  def self.standing_check (char, contacts)
    status = false
    alliance_standing = 0


    c = contacts.where(["name = :n", { n: char.corporation_name }])
    if c != []
      if c.first.standing >= 0
        corp_standing = c.first.standing
        status = true    
      end  
    end

    a = contacts.where(["name = :n", { n: char.alliance_name }])
    if a != []
     if a.first.standing >= 0
      alliance_standing = a.first.standing
      status = true
      end  
    end
    Rails.logger.info 'Standing Check for ' + char.corporation_name + ' / ' + corp_standing.to_s +  ' | ' + char.alliance_name + ' / ' + alliance_standing.to_s + ' - ' + status.to_s

    return status
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

  def self.validation_task (input)
    Rails.logger.info "=================================="
    Rails.logger.info "Start Validation Task - Refactor 1"
    Rails.logger.info "=================================="
    task_start = Time.now
    user = User.all
    change = false
    # Task Tracker +1
    user.each do |account|
      flag = nil
      status = ''
      # check if key is valid
      if (account.key_id.to_s.length == 7) and (account.v_code != nil or account.v_code != "")

        begin
          profile = EveOnline::Account::Characters.new(account.key_id, User.decrypt(account.v_code))

          if  account.primary_character_id == nil
            character = profile.characters[account.primary_character]
          else 
            for i in 0..(profile.characters.length - 1) do
              char_id = profile.characters[i].character_id
              if account.primary_character_id == char_id
                character = profile.characters[i]
              end
            end
          end

          standing = User.standing_check(character, Contact.all)

        rescue
          # Failed to retrieve account, key / ID are not nil
          status.concat('Error - Invalid character selection or key')
          flag = false
          character = nil
          standing = false
        end

        if standing == true
          # valid key, valid character
          status.concat(' Valid API, Accepted')
          flag = true
        else 
          # Valid key, primary character is out of group
          status.concat(' Invalid API, Out of Group Primary Character')
          flag = false
        end

      else
        # API key / v_code invalid (not full key)
        status.concat('Error - Invalid API code')
        flag = false
      end

      Rails.logger.info account.email + " | New flag: " +  flag.to_s + " | Existing Flag: " + account.valid_api.to_s + " | " + status.to_s
      task_end = Time.now
      task_length = User.time_diff(task_start, task_end)

      if $SETTING_REQUIRE_API == false 
        Rails.logger.info "<<<<Validation Disabled>>>>"
        if flag != account.valid_api 
        # Log.create :event_code => 99, :table => "Users", :task_length => task_length, :event => "Validation Task", :details => "API validation Disabled - No verification required (granting access to: " + account.email
        end
        flag = true
      end

      if flag != account.valid_api
        change = true
        if character != nil
          Rails.logger.info 'Name:' + account.primary_character_name.to_s
          if account.primary_character_name == nil || account.primary_character_name == ""
            Rails.logger.info 'Name update'
            account.update(primary_character_name: character.character_name)
          end
          account.update(valid_api: flag, primary_character_id: character.character_id) 
        else 
          account.update(valid_api: flag)
        end
        l = Log.create :event_code => 1, :table => "Users", :task_length => task_length, :event => "Validation Task", :details => input + " - API Change - " + account.email + "/" + account.primary_character_name.to_s + " - " + status.to_s
      end
      User.Admin_check_groups(account.id)
    end

    if change == false
      task_end = Time.now
      task_length = User.time_diff(task_start, task_end)
      l = Log.create :event_code => 0, :table => "Users", :task_length => task_length, :event => "Validation Task", :details =>  input + " - No changes made "
    end

    User.Admin_initialize

    Rails.logger.info "=================================="
    Rails.logger.info "End of API check"
    Rails.logger.info "=================================="
  end

end