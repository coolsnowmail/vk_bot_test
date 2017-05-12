# main bot work
class BotCycle < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot
      Like.make(bot_id)
      # puts "like"
      Msg.make(bot_id)
      # puts "message"
      Like.make(bot_id)
      # puts "like"
      Com.make(bot_id)
      # puts "comment"
      Like.make(bot_id)
      # puts "like"
      ResendMessage.make(bot_id)
      # puts "resent"
      AcceptRequest.make(bot_id)
      # puts "accessept"
      Post.make(bot_id)
      # puts "repost"
    end
  end
end
