# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/home/andrey/vk_bot_test/cron_log.log"
# #
# every :hour do
#   runner "Msg.make(4)"
# end


# every 2.minutes do
#   runner "Post.make(4)" , environment: "development"
# end

# every 2.minutes do
#   rake "post:doing" , environment: "development"
# end

# every 2.minutes do
#   command "cd /home/andrey/vk_bot_test && rake post:doing"
# end

every 30.minutes do
  command "cd /home/andrey/vk_bot_test && rake bots_run:go"
end


# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
