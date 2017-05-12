class KeyWordsController < ApplicationController
  before_action :set_key_word, only: [:edit, :update, :destroy]
  skip_before_action :authorize_admin

  def new
    @key_word = KeyWord.new
  end

  def create
    @key_word = @current_user.task.message_group.key_words.build(key_word_params)
    respond_to do |format|
      @key_word.save
      format.js
    end
  end

  def destroy
    @key_word.destroy
    respond_to do |format|
      format.html { redirect_to key_words_url, notice: 'Key word was successfully destroyed.' }
      format.js
    end
  end

  private

    def set_key_word
      @key_word = KeyWord.find(params[:id])
    end

    def key_word_params
      params.require(:key_word).permit(:word)
    end
end
