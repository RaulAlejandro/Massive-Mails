# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


# You will have to execute   whenever -i   to add the jobs to crontab

set :output, { error: 'log/demonio.log', standard: 'log/demonio.log' }

every :day, :at => '13:31pm' do
  command "`date` >> log/demonio.log"
  runner "Procesos.iniciar"
end


# http://www.howtogeek.com/121241/how-to-make-your-linux-pc-wake-from-sleep-automatically/
# 
# rtcwake: This program is used to enter a system sleep state until specified wakeup time.
# -m disk: This state offers the greatest power savings, and can be used even in the absence of low-level platform support for power management.
#          This state operates similarly to  Suspend-to-RAM, but includes a final step of writing memory contents to disk.
# -u:      Tells rtcwake that the hardware clock (in your computer’s BIOS) is set to UTC time.
# -t:      The -t option allows you to wake your computer up at a specific time.
#          This switch wants a number of seconds since the Unix epoch (00:00:00 UTC on January 1, 1970). 
#          
# rtcwake -m disk -u -t $(date +%s -d 'tomorrow 07:15')

# rtcwake -m disk -u -t $(date +%s -d 'next monday 07:15'