class BotsController < ApplicationController
  before_action :set_bot, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin

  def new
    @bot = Bot.new
  end

  def edit; end

  def create
    @bot = @current_user.task.bots.build(bot_params)
    respond_to do |format|
      @bot.save
      format.js
    end
  end

  def update
    respond_to do |format|
      @bot.update(bot_params)
      format.js
    end
  end

  def destroy
    @bot.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def set_bot
      @bot = Bot.find(params[:id])
    end

    def bot_params
      params.require(:bot).permit(:description, :login_vk, :password_vk, :access_token)
    end
end
