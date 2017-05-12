require "rails_helper"


RSpec.describe GroupsController, :type => :controller do

  let!(:bot) { create(:bot) }
  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:group) { create(:group) }
  let!(:group1) { create(:group) }
  let!(:message) { create(:message) }
  let!(:message1) { create(:message) }
  let!(:message_group) { create(:message_group) }
  let!(:key_word) { create(:key_word) }
  context 'for index' do
    it 'should render index' do
      session[:user_id] = user.id
      user.task = task
      task.groups << group
      task.groups << group1
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:groups)).to eq(user.task.groups)
      expect(flash[:notice]).to eq(nil)
    end
    it 'should rendirect to user if no group' do
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
      expect(assigns(:group)).to be_a_new(Group)
    end
    it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:user_id] = user.id
      get :edit, id: group.id
      expect(response).to render_template(:edit)
      expect(assigns(:group)).to eq(group)
    end
    it 'should redirect to user login' do
      get :edit, id: group.id
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do create' do
    it 'should get group create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :group => { url: 'https://vk.com/clubblah'}
      expect(Group.last.url).to eq('https://vk.com/clubblah')
      expect(response).to redirect_to(groups_path)
      expect(flash[:notice]).to eq(I18n.t('groups.was successfully created'))
    end
    it 'should get group create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :group => { url: nil }
      expect(response).to render_template(:new)
    end
  end

context 'should do update' do
  it 'should get group update success' do
    user.task = task
    session[:user_id] = user.id
    post :update, id: group.id, :group => { url: 'https://vk.com/clubblah' }
    expect(group.reload.url).to eq('https://vk.com/clubblah')
    expect(response).to redirect_to(groups_path)
    expect(flash[:notice]).to eq(I18n.t('groups.was successfully updated'))
  end
  it 'should get group update error' do
    user.task = task
    session[:user_id] = user.id
    post :update, id: group.id, :group => { url: '' }
    expect(response).to render_template(:edit)
  end
end

  context 'should do destroy' do
    it 'should get bot update success' do
      user.task = task
      session[:user_id] = user.id
      delete :destroy, id: group.id, format: :js
      expect(assigns(:group).destroyed?).to eq(true)
    end
  end
end