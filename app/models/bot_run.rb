# starts bot cycle for every active bot
class BotRun < ActiveRecord::Base
  def self.make
    Bot.all.each do |bot|
      if bot.status == 'Active'
        BotCycle.make(bot.id)
        sleep 120
      end
    end
  end
end
