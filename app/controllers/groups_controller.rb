class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin

  def index
    @groups = @current_user.task.groups
    flash[:notice] = t('groups.create a new group') unless @groups.any?
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = @current_user.task.groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: t('groups.was successfully created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path, notice: t('groups.was successfully updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: t('groups.was successfully destroyed') }
      format.js
    end
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:url)
    end
end
