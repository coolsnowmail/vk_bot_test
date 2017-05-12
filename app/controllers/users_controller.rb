class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_if_user_has_vk_group, only: [:show]
  before_action :check_if_user_has_any_task, only: [:show]
  before_action :check_if_user_has_any_comment, only: [:show]
  before_action :check_if_user_has_any_message, only: [:show]
  before_action :check_if_user_has_any_group, only: [:show]
  skip_before_action :authorize_admin, only: [:show]
  skip_before_action :authorize_user, only: [:new, :create, :edit, :update, :destroy, :index]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = @current_admin.users.build(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @current_admin, notice: t('users.User was successfully created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @current_admin, notice: t('users.User was successfully updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to @current_admin, notice: t('users.User was successfully destroyed') }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :vk_id)
    end

    def check_if_user_has_vk_group
      if @current_user.user_group.nil?
        redirect_to new_user_group_url, notice: t('users.enter_your_vk_group')
      end
    end

    def check_if_user_has_any_task
      unless @current_user.task
        redirect_to new_task_url, notice: t('tasks.enter your task')
      end
    end

    def check_if_user_has_any_comment
      unless @current_user.task.comments.size >= 2
        redirect_to new_comment_url, notice: t('tasks.enter your comment')
      end
    end

    def check_if_user_has_any_message
      unless @current_user.task.messages.size >= 2
        redirect_to new_message_url, notice: t('tasks.enter your message')
      end
    end

    def check_if_user_has_any_group
      unless @current_user.task.groups.size >= 2
        redirect_to new_group_url, notice: t('tasks.enter your group')
      end
    end

end
