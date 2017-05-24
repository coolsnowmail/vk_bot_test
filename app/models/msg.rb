# looks for vk_user and send him message
require 'net/http'

class Msg < ActiveRecord::Base
  def self.make(bot_id)
    coun = 0
    bot = Bot.find_by(id: bot_id)
    if bot && bot.check_message_limit < 20
      uri = URI.parse('https://api.vk.com/method/groups.getMembers')
      response = Net::HTTP.post_form(
        uri,
        'group_id' => bot.task.message_group.vk_id,
        'sort' => 'id_desc',
        'offset' => bot.task.message_offset,
        'count' => 1000,
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      vk_user_ids = JSON.parse(response.body)
puts vk_user_ids["response"]["items"].size
      bot.if_members_for_messsage_send_over(vk_user_ids['response']['count'])
      sleep rand(1..2)
      maked_messages = bot.check_if_message_have_maked
      vk_user_ids['response']['items'].each do |vk_user_id|
        unless maked_messages.include?(vk_user_id.to_s)
          uri = URI.parse('https://api.vk.com/method/groups.get')
          response = Net::HTTP.post_form(
            uri,
            'user_id' => vk_user_id,
            'offset' => 0,
            'extended' => 1,
            'count' => 999,
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          response = JSON.parse(response.body)
          sleep rand(1..2)
          vk_user_groups = []
          if response['response']
            response['response']['items'].each { |group| vk_user_groups.push(group['name']) }
          end
          bot.task.update(message_offset: bot.task.message_offset + 1)
          group_counter = 0
          if vk_user_groups.size > 15
            vk_user_groups.each do |group_name|
              group_counter += 1 if bot.task.message_group.take_key_words.any? { |word| group_name.include?(word) }
            end
          end
          coun += 1
puts coun
          if group_counter >= 5
            uri = URI.parse('https://api.vk.com/method/users.get')
            user_info = Net::HTTP.post_form(
              uri,
              'user_id' => vk_user_id,
              'fields' => 'counters',
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            sleep rand(1..2)
            user_info = JSON.parse(user_info.body)
            if user_info['response'].present?
              user_info = user_info['response'].first['counters']
              if user_info['photos'] > 10 && user_info['friends'] > 40 && user_info['followers'] > 10
                message = Message.find_by(id: bot.task.messages.ids[rand(bot.task.messages.ids.length)])
                uri = URI.parse('https://api.vk.com/method/messages.send')
                message_send = Net::HTTP.post_form(
                  uri,
                  'user_id' => vk_user_id,
                  'message' => message.text,
                  'access_token' => bot.access_token,
                  'v' => '5.62'
                )
                sleep rand(1..2)
                message_send = JSON.parse(message_send.body)
                if message_send['response']
                  message_track = bot.task.message_trakings.build(vk_user_id: vk_user_id,
                    message_id: message.id,
                    bot_id: bot.id)
                  unless message_track.save
                    uri = URI.parse('https://api.vk.com/method/messages.send')
                    response = Net::HTTP.post_form(
                      uri,
                      'user_id' => bot.task.user.admin.vk_id,
                      'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не сохраняет cообщения",
                      'access_token' => bot.access_token,
                      'v' => '5.62'
                    )
                    sleep rand(1..2)
                    bot.disactive_bot
                  end
puts vk_user_id
puts bot.task.message_offset
puts message_send
                  break
                end
              end
            end
          end
        end
      end
    end
  end
end
