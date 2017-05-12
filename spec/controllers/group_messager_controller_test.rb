require "rails_helper"


RSpec.describe GroupMessagerController, :type => :controller do

  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:message_group) { create(:message_group) }
  let!(:key_word) { create(:key_word) }

  context 'for new' do
    it 'should render new' do
      session[:user_id] = user.id
      xhr :get, :new
      expect(assigns(:message_group)).to be_a_new(MessageGroup)
    end
    it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      user.task = task
      task.message_group = message_group
      session[:user_id] = user.id
      xhr :get, :edit, id: message_group.id
      expect(response).to render_template(:edit)
      expect(assigns(:message_group)).to eq(message_group)
    end
    it 'should redirect to user login' do
      xhr :get, :edit, id: message_group.id
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do create' do
    it 'should get message_group create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :message_group => { name: 'message_group000', vk_id: 'molodosti' }, format: :js
      expect(MessageGroup.last.name).to eq('message_group000')
      expect(response).to render_template(partial: 'group_messager/_success_save')
    end
    it 'should get message_group create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :message_group => { name: nil, vk_id: nil }, format: :js
      expect(response).to render_template(partial: 'group_messager/_fail_save')
      expect(assigns(:message_group).persisted?).to eq(false)
    end
  end

  context 'should do update' do
    it 'should get message_group update success' do
      user.task = task
      session[:user_id] = user.id
      post :update, id: message_group.id, :message_group => { name: 'message_group000', vk_id: 'molodosti' }, format: :js
      expect(message_group.reload.name).to eq('message_group000')
      expect(response).to render_template(:update)
    end
    it 'should get message_group update error' do
      user.task = task
      session[:user_id] = user.id
      post :update, id: message_group.id, :message_group => { name: nil, vk_id: nil }, format: :js
      expect(response).to render_template(:update)
    end
  end
end