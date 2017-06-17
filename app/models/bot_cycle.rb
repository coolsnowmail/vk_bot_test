# main bot work
class BotCycle < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot
      # Like.make(bot_id)
      # puts "like"
      # Msg.make(bot_id)
      # puts "message"
      LikeUp.make(bot_id)
      puts "like"
      Com.make(bot_id)
      puts "comment"
      LikeUp.make(bot_id)
      puts "like"
      ResendMessage.make(bot_id)
      puts "resent"
      AcceptRequest.make(bot_id)
      puts "accessept"
      LikeUp.make(bot_id)
      puts "like"
      Post.make(bot_id)
      puts "repost"
      puts "----------------------------------"
      puts "----------------------------------"
    end
  end
end
