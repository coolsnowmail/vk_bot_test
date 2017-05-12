# resend all messages to user any bot was send
class ResendMessage < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot
      uri = URI.parse('https://api.vk.com/method/messages.get')
      response = Net::HTTP.post_form(
        uri,
        'out' => 0,
        'count' => 200,
        'offset' => 0,
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      messages = JSON.parse(response.body)
      sleep 1
      if messages['response']
        messages['response']['items'].each do |message|
          if message['read_state'].zero?
            uri = URI.parse('https://api.vk.com/method/messages.send')
            response = Net::HTTP.post_form(
              uri,
              'user_id' => bot.task.user.vk_id,
              'forward_messages' => message['id'],
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            messages = JSON.parse(response.body)
            sleep rand(1..2)
            uri = URI.parse('https://api.vk.com/method/messages.markAsRead')
            response = Net::HTTP.post_form(
              uri,
              'message_ids' => message['id'],
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            sleep 1
          end
        end
      end
      if messages['error']
        uri = URI.parse('https://api.vk.com/method/messages.send')
        response = Net::HTTP.post_form(
          uri,
          'user_id' => bot.task.user.vk_id,
          'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не пересылает cообщения",
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        bot.disactive_bot
      end
    end
  end
end
