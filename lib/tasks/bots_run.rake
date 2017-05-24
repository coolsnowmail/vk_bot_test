namespace :bots_run do
  task go: :environment do
    BotRun.make
  end
end

# 0-59 * * * * /bin/bash -l -c 'cd /home/andrey/vk_bot_test && rake post:doing >> /home/andrey/vk_bot_test/cron_log.log 2>&1'