require "rails_helper"


RSpec.describe KeyWordsController, :type => :controller do

  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:key_word) { create(:key_word) }
  let!(:message_group) { create(:message_group) }

  context 'for new' do
    it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do destroy' do
    it 'should get kye word destroy success' do
      user.task = task
      task.message_group = message_group
      message_group.key_words << key_word
      session[:user_id] = user.id
      delete :destroy, id: key_word.id, format: :js
      expect(assigns(:key_word).destroyed?).to eq(true)
    end
  end

  context 'should do create' do
    it 'should get key_word create success' do
      user.task = task
      task.message_group = message_group
      session[:user_id] = user.id
      post :create, :key_word => { word: 'wording' }, format: :js
      expect(KeyWord.last.word).to eq('wording')
    end
    it 'should get key_word create error' do
      user.task = task
      task.message_group = message_group
      session[:user_id] = user.id
      post :create, :key_word => { word: nil }, format: :js
      expect(assigns(:key_word).persisted?).to eq(false)
    end
  end
end