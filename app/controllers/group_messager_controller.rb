class GroupMessagerController < ApplicationController
  skip_before_action :authorize_admin
  before_action :set_message_group, only: [:edit, :update]

  def new
    @message_group = MessageGroup.new
  end

  def edit; end

  def create
    @message_group = @current_user.task.build_message_group(message_group_params)

    if @message_group.save
      return render partial: 'success_save'
    else
      return render partial: 'fail_save'
    end
  end

  def update
    respond_to do |format|
      @message_group.update(message_group_params)
      format.js
    end
  end

  private

    def set_message_group
      @message_group = MessageGroup.find(params[:id])
    end

    def message_group_params
      params.require(:message_group).permit(:name, :vk_id)
    end
end
