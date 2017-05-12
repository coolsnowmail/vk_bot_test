require "rails_helper"


RSpec.describe MessagesController, :type => :controller do

  let!(:bot) { create(:bot) }
  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:message) { create(:message) }
  let!(:message1) { create(:message) }
  let!(:message_group) { create(:message_group) }
  let!(:key_word) { create(:key_word) }
  context 'for index' do
    it 'should render index' do
      session[:user_id] = user.id
      user.task = task
      task.messages << message
      task.messages << message1
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:messages)).to eq(user.task.messages)
      expect(flash[:notice]).to eq(nil)
    end
    it 'should rendirect to user if no comment' do
      session[:user_id] = user.id
      user.task = task
      get :index
      expect(response).to render_template(:index)
      expect(controller).to set_flash[:notice]
    end
  end

  context 'for new' do
    it 'should render new' do
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:message)).to be_a_new(Message)
    end
    it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:user_id] = user.id
      get :edit, id: message.id
      expect(response).to render_template(:edit)
      expect(assigns(:message)).to eq(message)
    end
    it 'should redirect to user login' do
      get :edit, id: message.id
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do create' do
    it 'should get message create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :message => { text: 'j4655578 fsddfsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds'}
      expect(Message.last.text).to eq('j4655578 fsddfsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds')
      expect(response).to redirect_to(messages_path)
      expect(flash[:notice]).to eq(I18n.t('messages.was successfully created'))
    end
    it 'should get message create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :message => { text: nil }
      expect(response).to render_template(:new)
    end
  end

context 'should do update' do
  it 'should get message update success' do
    user.task = task
    session[:user_id] = user.id
    post :update, id: message.id, :message => { text: 'fsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds' }
    expect(message.reload.text).to eq('fsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds')
    expect(response).to redirect_to(messages_path)
    expect(flash[:notice]).to eq(I18n.t('messages.was successfully updated'))
  end
  it 'should get message update error' do
    user.task = task
    session[:user_id] = user.id
    post :update, id: message.id, :message => { text: '' }
    expect(response).to render_template(:edit)
  end
end

  context 'should do destroy' do
    it 'should get bot update success' do
      user.task = task
      session[:user_id] = user.id
      delete :destroy, id: message.id, format: :js
      expect(assigns(:message).destroyed?).to eq(true)
    end
  end
end