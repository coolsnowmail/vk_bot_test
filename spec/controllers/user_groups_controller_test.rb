require "rails_helper"


RSpec.describe UserGroupsController, :type => :controller do

  let!(:bot) { create(:bot) }
  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:user_group) { create(:user_group) }

  context 'for new' do
    it 'should render new' do
      session[:user_id] = user.id
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:user_group)).to be_a_new(UserGroup)
    end
    it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:user_id] = user.id
      get :edit, id: user_group.id
      expect(response).to render_template(:edit)
      expect(assigns(:user_group)).to eq(user_group)
    end
    it 'should redirect to user login' do
      get :edit, id: user_group.id
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do create' do
    it 'should get user_group create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :user_group => { description: 'example', url: '654624652' }
      expect(UserGroup.last.description).to eq('example')
      expect(response).to redirect_to(user_url(user.id))
      expect(flash[:notice]).to eq(I18n.t('user_groups.successfully created'))
    end
    it 'should get message create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :user_group => { url: nil }
      expect(response).to render_template(:new)
    end
  end

  context 'should do update' do
    it 'should get user_group update success' do
      user.task = task
      session[:user_id] = user.id
      post :update, id: user_group.id, :user_group => { description: 'example', url: '654624652' }, format: :js
      expect(user_group.reload.description).to eq('example')
      expect(response.status).to eq(200)
    end
    it 'should get user_group update error' do
      user.task = task
      user_group_url = user_group.url
      session[:user_id] = user.id
      post :update, id: user_group.id, :user_group => { url: nil }, format: :js
      expect(user_group.url).to eq(user_group_url)
    end
  end
end