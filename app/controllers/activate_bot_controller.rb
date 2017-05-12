class ActivateBotController < ApplicationController
  skip_before_action :authorize_admin
  def activate
    bot = Bot.find_by(id: params[:bot_id])
    return redirect_to user_path(@current_user), notice: t('bots.params error') unless bot
    return redirect_to user_path(@current_user), notice: t('enter group for messages') unless bot.task.message_group
    return redirect_to user_path(@current_user), notice: t('enter key words') unless bot.task.message_group.key_words.any?
puts 1111111111111111111111111111111111111111
puts    vk_id = check_token(bot)
puts 1111111111111111111111111111111111111111
    return redirect_to user_path(@current_user), notice: t('bots.access token error') unless vk_id['response']
    return redirect_to user_path(@current_user), notice: t('bots.access token error') unless vk_id['response'].any?
    if vk_id['response']
      bot_vk_id = vk_id['response'].first['id']
      bot_vk_ids = []
      Bot.all.each {|i| bot_vk_ids.push(i.vk_id)}
      unless bot_vk_ids.include? bot_vk_id
        bot.update(status: 3, vk_id: bot_vk_id)
        redirect_to user_path(@current_user), notice: t('bots.bot activated')
      else
        redirect_to user_path(@current_user), notice: t('bots.activate error')
      end
    end
  end

  private

    def check_token(bot)
      uri = URI.parse('https://api.vk.com/method/users.get')
      response = Net::HTTP.post_form(
        uri,
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      bot_vk_id = JSON.parse(response.body)
      bot_vk_id
    end
end
