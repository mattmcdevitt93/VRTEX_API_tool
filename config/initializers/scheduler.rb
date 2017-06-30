#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

  $s = Rufus::Scheduler.singleton

      $s.every '15m' do
            User.validation_task ('auto')
            Toolbox.discord_check($bot)
      end

      $s.every '1m' do
      	Toolbox.timesheet_check('auto')
      end      