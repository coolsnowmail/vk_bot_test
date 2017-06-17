# starts bot cycle for every active bot
class BotResend < ActiveRecord::Base
  def self.make
    Bot.all.each do |bot|
      if bot.access_token.present?
        ResendMessage.make(bot.id)
        sleep 100
      end
    end
  end
end
