# accept all friend request to bot
require 'net/http'

class AcceptRequest < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot
      uri = URI.parse('https://api.vk.com/method/friends.getRequests')
      response = Net::HTTP.post_form(
        uri,
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
puts      request = JSON.parse(response.body)
      sleep 1
      if request['response'] && request['response']['items'].any?
        request['response']['items'].each do |request_id|
          uri = URI.parse('https://api.vk.com/method/friends.add')
          response = Net::HTTP.post_form(
            uri,
            'user_id' => request_id,
            'follow' => 0,
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          sleep rand(1..3)
          response = JSON.parse(response.body)
          if response['error']
            uri = URI.parse('https://api.vk.com/method/messages.send')
            response = Net::HTTP.post_form(
              uri,
              'user_id' => bot.task.user.vk_id,
              'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не "\
                           "принимает друзей. Ошибка #{response['error']['error_msg']}",
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            bot.disactive_bot
          end
        end
      end
    end
  end
end
