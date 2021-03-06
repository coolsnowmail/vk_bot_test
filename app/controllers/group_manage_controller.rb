class GroupManageController < ApplicationController
  skip_before_action :authorize_admin
  def group_leave_join
    return redirect_to groups_path, notice: "вы не ввели ид группы" if params["group_id"] == ""
    @current_user.task.bots.each do |bot|
      group_action(params["act"], params["group_id"], bot.access_token)
      if response['error']
        uri = URI.parse('https://api.vk.com/method/messages.send')
        response = Net::HTTP.post_form(
          uri,
          'user_id' => bot.task.user.admin.vk_id,
          'message' => "бот № #{bot.id} юзера #{bot.task.user.name} вступает/ухидит из групп. код: #{response['error']}",
          'access_token' => bot.access_token,
          'v' => '5.62'
        )
        sleep 2
      end
    end
    return redirect_to groups_path, notice: "уcgешно"
  end

  private

  def group_action(action, group_id, token)
    action == 'leave'? meth = 'groups.leave' : meth = 'groups.join'
    uri = URI.parse('https://api.vk.com/method/' + meth)
    response = Net::HTTP.post_form(
      uri,
      'group_id' => group_id,
      'access_token' => token,
      'v' => '5.67'
    )
    response = JSON.parse(response.body)
    sleep 2
    puts response
  end
end
