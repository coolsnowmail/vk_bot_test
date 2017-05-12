require "rails_helper"


RSpec.describe BotsController, :type => :controller do

  let!(:bot) { create(:bot) }
  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:message_group) { create(:message_group) }
  let!(:key_word) { create(:key_word) }
  context 'for new' do
    it 'should render new' do
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:bot)).to be_a_new(Bot)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:user_id] = user.id
      get :edit, id: bot.id
      expect(response).to render_template(:edit)
      expect(assigns(:bot)).to eq(bot)
    end
  end

  context 'should do create' do
    it 'should get bot create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :bot => { access_token: 'j4655578' }, format: :js
      expect(Bot.all.count).to eq(1)
      expect(response).to render_template('bots/create')

    end
    it 'should get bot create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :bot => { description: 'namjjnje', access_token: 'access_tokejnikjkn455njnjjj4655578' }, format: :js
      expect(assigns(:bot).access_token).to eq(Bot.last.access_token)
    end
  end

  context 'should do update' do
    it 'should get bot update error' do
      user.task = task
      session[:user_id] = user.id
      post :update, id: bot.id, :bot => { access_token: 'j4655578' }, format: :js
      expect(Bot.all.count).to eq(1)
      expect(response).to render_template('bots/update')
    end

    it 'should get bot update success' do
      user.task = task
      session[:user_id] = user.id
      post :update, id: bot.id, :bot => { description: 'namjjnje', access_token: 'access_tokejnikjkn455njnjjj4655578' }, format: :js
      expect(assigns(:bot).access_token).to eq(Bot.last.access_token)
    end
  end

  context 'should do destroy' do
    it 'should get bot update success' do
      user.task = task
      session[:user_id] = user.id
      delete :destroy, id: bot.id, format: :js
      expect(assigns(:bot).destroyed?).to eq(true)
    end
  end
end