class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_admin

  def index
    @comments = @current_user.task.comments
    flash[:notice] = t('comments.create a new comment') unless @comments.any?
  end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = @current_user.task.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_path, notice: t('comments.was successfully created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comments_path, notice: t('comments.was successfully updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: t('comments.was successfully destroyed') }
      format.js
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
