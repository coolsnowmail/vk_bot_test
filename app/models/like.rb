# bot make likes
require 'net/http'

class Like < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot && bot.check_like_limit < 350 && bot.status == 'Active'
      if bot.task.groups.empty?
        uri = URI.parse('https://api.vk.com/method/messages.send')
        response = Net::HTTP.post_form(
          uri,
          'user_id' => bot.task.user.vk_id,
          'message' => "У бота № #{bot.id} юзера #{bot.task.user.name} закончились группы для лайков. Срочно добавте новвы группы",
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        sleep rand(1..3)
        response = Net::HTTP.post_form(
          uri,
          'user_id' => bot.task.user.admin.vk_id,
          'message' => "У бота № #{bot.id} юзера #{bot.task.user.name} закончились группы для лайков. Срочно добавте новвы группы",
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        bot.disactive_bot
      else
        group_id = bot.task.groups.first.url
        uri = URI.parse('https://api.vk.com/method/groups.getMembers')
        response = Net::HTTP.post_form(
          uri,
          'group_id' => group_id,
          'sort' => 'id_desc',
          'offset' => bot.offset_change,
          'count' => rand(1..3),
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        vk_user_ids = JSON.parse(response.body)
        bot.disactive_bot if vk_user_ids['error']
        bot.if_members_over(vk_user_ids['response']['count'])
 puts vk_user_ids
        sleep rand(1..3)
        maked_likes = bot.check_if_like_have_maked
        vk_user_ids['response']['items'].each do |vk_user_id|
          unless maked_likes.include?(vk_user_id)
            uri = URI.parse('https://api.vk.com/method/users.get')
            response = Net::HTTP.post_form(
              uri,
              'user_ids' => vk_user_id,
              'fields' => 'photo_id',
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            response = JSON.parse(response.body)
            if response['response']
              if response['response'].first['deactivated']
                like_track_for_empty_or_banned(bot, vk_user_id, group_id, 2)
# puts "buned"
              end
            end
# puts response
            sleep rand(1..3)
            # photo_id = response['response'].first['photo_id']
            if response['response'].first['photo_id']
              photo_id = response['response'].first['photo_id']
              photo_id = photo_id.split('_').second
              uri = URI.parse('https://api.vk.com/method/likes.add')
              response = Net::HTTP.post_form(
                uri,
                'type' => 'photo',
                'owner_id' => vk_user_id,
                'item_id' => photo_id,
                'access_token' => bot.access_token,
                'v' => '5.62'
              )
              response = JSON.parse(response.body)
              sleep rand(10..20)
              if response['error']
                uri = URI.parse('https://api.vk.com/method/messages.send')
                response = Net::HTTP.post_form(
                  uri,
                  'user_id' => bot.task.user.admin.vk_id,
                  'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не лайкает. код: #{response['error']}",
                  'access_token' => bot.access_token,
                  'v' => '5.62'
                )
                sleep rand(1..3)
                uri = URI.parse('https://api.vk.com/method/messages.send')
                response = Net::HTTP.post_form(
                  uri,
                  'user_id' => bot.task.user.vk_id,
                  'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не лайкает. код: #{response['error']}",
                  'access_token' => bot.access_token,
                  'v' => '5.62'
                )
                bot.disactive_bot
                like_track(bot, vk_user_id, group_id)
                break
              end
# puts response
# puts "photo"
              like_track(bot, vk_user_id, group_id)
              errors_alert(response)
            else
              uri = URI.parse('https://api.vk.com/method/wall.get')
              response = Net::HTTP.post_form(
                uri,
                'owner_id' => vk_user_id,
                'count' => 1,
                'access_token' => bot.access_token,
                'v' => '5.62'
              )
              response = JSON.parse(response.body)
# puts response
              if response['response']
                if response['response']['items'].any?
                  vk_user_post_id = response['response']['items'].first['id']
                  sleep rand(1..3)
                  uri = URI.parse('https://api.vk.com/method/likes.add')
                  response = Net::HTTP.post_form(
                    uri,
                    'type' => 'post',
                    'owner_id' => vk_user_id,
                    'item_id' => vk_user_post_id,
                    'access_token' => bot.access_token,
                    'v' => '5.62'
                  )
                  response = JSON.parse(response.body)
                  sleep rand(9..20)
                  if response['error']
                    uri = URI.parse('https://api.vk.com/method/messages.send')
                    response = Net::HTTP.post_form(
                      uri,
                      'user_id' => bot.task.user.admin.vk_id,
                      'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не лайкает. код: #{response['error']}",
                      'access_token' => bot.access_token,
                      'v' => '5.62'
                    )
                    sleep rand(1..3)
                    response = Net::HTTP.post_form(
                      uri,
                      'user_id' => bot.task.user.vk_id,
                      'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не лайкает. код: #{response['error']}",
                      'access_token' => bot.access_token,
                      'v' => '5.62'
                    )
                    bot.disactive_bot
                    like_track(bot, vk_user_id, group_id)
                    break
                  end
# puts response
# puts "post"
                  like_track(bot, vk_user_id, group_id)
                  errors_alert(response)
                else
                  like_track_for_empty_or_banned(bot, vk_user_id, group_id, 3)
# puts "empty"
                end
              end
            end
          end
        end
      end
    end
  end

  def self.errors_alert(response)
    if response['error']
      uri = URI.parse('https://api.vk.com/method/messages.send')
      Net::HTTP.post_form(
        uri,
        'user_id' => bot.task.user.vk_id,
        'message' => response['error']['error_msg'],
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      sleep rand(1..3)
      Net::HTTP.post_form(
        uri,
        'user_id' => bot.task.user.admin.vk_id,
        'message' => response['error']['error_msg'],
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      sleep rand(1..3)
      bot.disactive_bot
    end
  end

  def self.like_track(bot, vk_user_id, group_id)
    like_track = bot.task.like_trakings.build(
      vk_user_id: vk_user_id,
      offset: bot.offset_change,
      vk_group_id: group_id,
      bot_id: bot.id
    )
    unless like_track.save
      uri = URI.parse('https://api.vk.com/method/messages.send')
      Net::HTTP.post_form(
        uri,
        'user_id' => bot.task.user.admin.vk_id,
        'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не сохраняет лайки",
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      sleep rand(1..3)
      Net::HTTP.post_form(
        uri,
        'user_id' => bot.task.user.vk_id,
        'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не сохраняет лайки",
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      bot.disactive_bot
      sleep rand(1..3)
    end
  end

  def self.like_track_for_empty_or_banned(bot, vk_user_id, group_id, status)
    like_track = bot.task.like_trakings.build(
      vk_user_id: vk_user_id,
      offset: bot.offset_change,
      vk_group_id: group_id,
      bot_id: bot.id,
      vk_user_status: status
    )
    unless like_track.save
      uri = URI.parse('https://api.vk.com/method/messages.send')
      response = Net::HTTP.post_form(
        uri,
        'user_id' => bot.task.user.admin.vk_id,
        'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не сохраняет лайки",
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      sleep rand(1..3)
      response = Net::HTTP.post_form(
        uri,
        'user_id' => bot.task.user.vk_id,
        'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не сохраняет лайки",
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      bot.disactive_bot
      sleep rand(1..3)
    end
  end
end
