# do vk post from vk group to bot wall
class Post < ActiveRecord::Base
  def self.make(bot_id)
    bot = Bot.find_by(id: bot_id)
    if bot
      uri = URI.parse('https://api.vk.com/method/wall.get')
      response = Net::HTTP.post_form(
        uri,
        'owner_id' => "-#{bot.task.user.user_group.url}",
        'offset' => 0,
        'count' => 1,
        'filter' => 'owner',
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      sleep 1
      group_post = JSON.parse(response.body)
      if group_post['response'] && group_post['response']['items'].any?
        group_post_id = group_post['response']['items'].first['id']
        uri = URI.parse('https://api.vk.com/method/wall.get')
        response = Net::HTTP.post_form(
          uri,
          'offset' => 0,
          'count' => 1,
          'filter' => 'owner',
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        sleep 1
        user_post = JSON.parse(response.body)
        if user_post['response']
          if user_post['response']['items'].empty?
            uri = URI.parse('https://api.vk.com/method/wall.repost')
            response = Net::HTTP.post_form(
              uri,
              'object' => "wall-#{bot.task.user.user_group.url}_#{group_post_id}",
              'access_token' => bot.access_token,
              'v' => '5.62'
            )
            sleep 1
            response = JSON.parse(response.body)
            if response['error']
              uri = URI.parse('https://api.vk.com/method/messages.send')
              response = Net::HTTP.post_form(
                uri,
                'user_id' => bot.task.user.vk_id,
                'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не "\
                             'постит записи из группы на стену бота '\
                             "пользователя #{response['error']}",
                'access_token' => bot.access_token,
                'v' => '5.62'
              )
              bot.disactive_bot
            end
          elsif user_post['response']['items'].any?
            if user_post['response']['items'].first['copy_history']
              user_post_id = user_post['response']['items'] \
                             .first['copy_history'] \
                             .first['id']
              unless user_post_id == group_post_id
                uri = URI.parse('https://api.vk.com/method/wall.repost')
                response = Net::HTTP.post_form(
                  uri,
                  'object' => "wall-#{bot.task.user.user_group.url}"\
                              "_#{group_post_id}",
                  'access_token' => bot.access_token,
                  'v' => '5.62'
                )
                sleep 1
                response = JSON.parse(response.body)
                if response['error']
                  uri = URI.parse('https://api.vk.com/method/messages.send')
                  response = Net::HTTP.post_form(
                    uri,
                    'user_id' => bot.task.user.vk_id,
                    'message' => "бот № #{bot.id} юзера #{bot.task.user.name}"\
                                 ' не постит записи из группы на стену бота '\
                                 "пользователя #{response['error']}",
                    'access_token' => bot.access_token,
                    'v' => '5.62'
                  )
                  bot.disactive_bot
                end
              end
            else
              uri = URI.parse('https://api.vk.com/method/wall.repost')
              response = Net::HTTP.post_form(
                uri,
                'object' => "wall-#{bot.task.user.user_group.url}"\
                            "_#{group_post_id}",
                'access_token' => bot.access_token,
                'v' => '5.62'
              )
              if response['error']
                uri = URI.parse('https://api.vk.com/method/messages.send')
                Net::HTTP.post_form(
                  uri,
                  'user_id' => bot.task.user.vk_id,
                  'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не"\
                               ' постит записи из группы на стену '\
                               "бота пользователя #{response['error']}",
                  'access_token' => bot.access_token,
                  'v' => '5.62'
                )
                bot.disactive_bot
              end
            end
          end
        end
        if user_post['error']
          uri = URI.parse('https://api.vk.com/method/messages.send')
          Net::HTTP.post_form(
            uri,
            'user_id' => bot.task.user.vk_id,
            'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не "\
                         'получает посты со стены бота '\
                         "пользователя #{response['error']}",
            'access_token' => bot.access_token,
            'v' => '5.62'
          )
          bot.disactive_bot
        end
      end
      if group_post['error']
        uri = URI.parse('https://api.vk.com/method/messages.send')
        Net::HTTP.post_form(
          uri,
          'user_id' => bot.task.user.vk_id,
          'message' => "бот № #{bot.id} юзера #{bot.task.user.name} не "\
                       'получает посты со стены группы '\
                       "пользователя #{response['error']}",
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        bot.disactive_bot
      end
    end
  end
end
