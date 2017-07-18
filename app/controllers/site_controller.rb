require 'net/http'

class SiteController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_admin

  def landing
    @client = Client.new
  end

  def sending
    @client = Client.new(client_params)
    if @client.save
      bot = Bot.all.where(status: 3).first
      uri = URI.parse('https://api.vk.com/method/messages.send')
      Net::HTTP.post_form(
        uri,
        'user_id' => 325780780,
        'message' => "Запись на урок: имя: #{@client.name}, уровень языка: #{@client.level}, телефон: #{@client.phone}",
        'access_token' => bot.access_token,
        'v' => '5.62'
      )
      flash[:notice] = "Вы успешно записались на урок!"
      return render partial: 'success_save'
    else
      flash[:notice] = "Вы неверно заполнили форму"
      return render partial: 'fail_save'
    end
  end

  def clients
    @clients = Client.all
  end

  def destroy_client
  @client = Client.find_by(id: params[:client_id])
  @client.destroy
    return render partial: 'delete'
  end

  private

    def client_params
      params.require(:client).permit(:name, :level, :phone)
    end
end