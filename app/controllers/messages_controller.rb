class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin

  def index
    @messages = @current_user.task.messages
    flash[:notice] = t('messages.create a new message') unless @messages.any?
  end

  def new
    @message = Message.new
  end

  def edit; end

  def create
    @message = @current_user.task.messages.build(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: t('messages.was successfully created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to messages_path, notice: t('messages.was successfully updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: t('messages.was successfully destroyed') }
      format.js
    end
  end

  private

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:text)
    end
end
