# makes comment in one of a bot's group
require 'net/http'

class Com < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot && bot.check_com_limit < 39
      uri = URI.parse('https://api.vk.com/method/groups.get')
      response = Net::HTTP.post_form(
        uri,
        'offset' => 0,
        'count' => 1000,
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      bot_piar_groups = JSON.parse(response.body)
      sleep 1
      if bot_piar_groups['response'] && bot_piar_groups['response']['items'].any?
        array_bot_piar_groups = bot_piar_groups['response']['items']
        bot_piar_group = array_bot_piar_groups[rand(array_bot_piar_groups.length)]
        comment = Comment.find_by(id: bot.task.comments.ids[rand(bot.task.comments.ids.length)])
        uri = URI.parse('https://api.vk.com/method/wall.get')
        response = Net::HTTP.post_form(
          uri,
          'owner_id' => "-#{bot_piar_group}",
          'offset' => 2,
          'count' => 1,
          'filter' => 'all',
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        response = JSON.parse(response.body)
        if response['response']
          post_id = response['response']['items'].first['id']
          make(bot_id) unless post_id.present?
        end
        sleep 1
        if response['error']
          uri = URI.parse('https://api.vk.com/method/messages.send')
          response = Net::HTTP.post_form(
            uri,
            'user_id' => bot.task.user.vk_id,
            'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не "\
                         "получает посты со стены #{response['error']}",
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          sleep rand(1..3)
          uri = URI.parse('https://api.vk.com/method/messages.send')
          response = Net::HTTP.post_form(
            uri,
            'user_id' => bot.task.user.admin.vk_id,
            'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не "\
                         "получает посты со стены #{response['error']}",
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          bot.disactive_bot
        end
        sleep 1
        uri = URI.parse('https://api.vk.com/method/wall.createComment')
        response = Net::HTTP.post_form(
          uri,
          'owner_id' => "-#{bot_piar_group}",
          'post_id' => post_id,
          'message' => comment.text,
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        response = JSON.parse(response.body)
        sleep rand(1..2)
        if response['error']
          uri = URI.parse('https://api.vk.com/method/messages.send')
          response = Net::HTTP.post_form(
            uri,
            'user_id' => bot.task.user.vk_id,
            'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не"\
                         " постит в группу #{response['error']}",
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          sleep rand(1..3)
          uri = URI.parse('https://api.vk.com/method/messages.send')
          response = Net::HTTP.post_form(
            uri,
            'user_id' => bot.task.user.admin.vk_id,
            'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не"\
                         " постит в группу #{response['error']}",
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          bot.disactive_bot
        end
        if response['response']
          comment_track = bot.task.comment_trakings.build(comment_id: comment.id, bot_id: bot.id)
          unless comment_track.save
            uri = URI.parse('https://api.vk.com/method/messages.send')
            Net::HTTP.post_form(
              uri,
              'user_id' => bot.task.user.vk_id,
              'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не постит в группу",
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            sleep rand(1..2)
            uri = URI.parse('https://api.vk.com/method/messages.send')
            Net::HTTP.post_form(
              uri,
              'user_id' => bot.task.user.admin.vk_id,
              'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не постит в группу",
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
