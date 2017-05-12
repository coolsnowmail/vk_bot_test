require "rails_helper"


RSpec.describe UsersController, :type => :controller do

  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user_group) { create(:user_group) }
  let!(:task) { create(:task) }
  let!(:admin) { create(:admin) }
  let!(:message) { create(:message) }
  let!(:message1) { create(:message) }
  let!(:group) { create(:group) }
  let!(:group1) { create(:group) }
  let!(:comment) { create(:comment) }
  let!(:comment1) { create(:comment) }
  context 'for show' do
    it 'should render show' do
      session[:user_id] = user.id
      user.task = task
      task.messages << message
      task.messages << message1
      task.comments << comment
      task.comments << comment1
      task.groups << group
      task.groups << group1
      user.user_group = user_group
      get :show, id: user.id
      expect(response).to render_template(:show)
      expect(flash[:notice]).to eq(nil)
      expect(assigns(:user)).to eq(user)
      expect(assigns(:current_user)).to eq(user)
    end
    it 'should redirect to new_user_group_url' do
      session[:user_id] = user.id
      user.task = task
      task.messages << message
      task.messages << message1
      task.comments << comment
      task.comments << comment1
      task.groups << group
      task.groups << group1
      get :show, id: user.id
      expect(response).to redirect_to(new_user_group_url)
      expect(flash[:notice]).to eq(I18n.t('users.enter_your_vk_group'))
    end
    it 'should redirect to new_task_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      get :show, id: user.id
      expect(response).to redirect_to(new_task_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your task'))
    end
    it 'should redirect to new_comment_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      user.task = task
      task.messages << message
      task.messages << message1
      task.groups << group
      task.groups << group1
      get :show, id: user.id
      expect(response).to redirect_to(new_comment_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your comment'))
    end
    it 'should redirect to new_comment_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      user.task = task
      task.messages << message
      task.messages << message1
      task.groups << group
      task.groups << group1
      task.comments << comment
      get :show, id: user.id
      expect(response).to redirect_to(new_comment_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your comment'))
    end
    it 'should redirect to new_message_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      user.task = task
      task.comments << comment
      task.comments << comment1
      task.groups << group
      task.groups << group1
      get :show, id: user.id
      expect(response).to redirect_to(new_message_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your message'))
    end
    it 'should redirect to new_message_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      user.task = task
      task.comments << comment
      task.comments << comment1
      task.groups << group
      task.groups << group1
      task.messages << message
      get :show, id: user.id
      expect(response).to redirect_to(new_message_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your message'))
    end
    it 'should redirect to new_group_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      user.task = task
      task.messages << message
      task.messages << message1
      task.comments << comment
      task.comments << comment1
      get :show, id: user.id
      expect(response).to redirect_to(new_group_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your group'))
    end
    it 'should redirect to new_group_url' do
      session[:user_id] = user.id
      user.user_group = user_group
      user.task = task
      task.messages << message
      task.messages << message1
      task.comments << comment
      task.comments << comment1
      task.groups << group
      get :show, id: user.id
      expect(response).to redirect_to(new_group_url)
      expect(flash[:notice]).to eq(I18n.t('tasks.enter your group'))
    end
  end

  context 'for new' do
    it 'should render new' do
      session[:admin_id] = admin.id
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'should redirect to admin login' do
      get :new
      expect(response).to redirect_to(admin_login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:admin_id] = admin.id
      get :edit, id: user.id
      expect(response).to render_template(:edit)
      expect(assigns(:user)).to eq(user)
    end
    it 'should redirect to admin login' do
      get :edit, id: user.id
      expect(response).to redirect_to(admin_login_url)
    end
  end

  context 'should do destroy' do
    it 'should destroy user' do
      session[:admin_id] = admin.id
      get :edit, id: user.id
      delete :destroy, id: user.id
      expect(assigns(:user).destroyed?).to eq(true)
      expect(response).to redirect_to(admin_path(admin.id))
      expect(flash[:notice]).to eq(I18n.t('users.User was successfully destroyed'))
    end
  end

  context 'should do create' do
    it 'should get user create success' do
      session[:admin_id] = admin.id
      post :create, :user => { name: 'name', password: '123', password_conformation: '123', vk_id: '135454534' }
      expect(User.last.vk_id).to eq('135454534')
      expect(response).to redirect_to(admin_path(admin.id))
      expect(flash[:notice]).to eq(I18n.t('users.User was successfully created'))
    end
    it 'should get user create error' do
      session[:admin_id] = admin.id
      post :create, :user => { name: nil, password: '123', password_conformation: '123', vk_id: '135454534' }
      expect(response).to render_template(:new)
    end
  end

  context 'should do update' do
    it 'should get user update success' do
      session[:admin_id] = admin.id
      post :update, id: user.id, :user => { name: 'name000', password: '123', password_conformation: '123', vk_id: '13545554' }
      expect(user.reload.name).to eq('name000')
      expect(response).to redirect_to(admin_path(admin.id))
      expect(flash[:notice]).to eq(I18n.t('users.User was successfully updated'))
    end
    it 'should get user update error' do
      session[:admin_id] = admin.id
      post :update, id: user.id, :user => { name: nil, password: '123', password_conformation: '123', vk_id: '135454534' }
      expect(response).to render_template(:edit)
    end
  end
end