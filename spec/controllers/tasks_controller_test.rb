require "rails_helper"


RSpec.describe TasksController, :type => :controller do

  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  context 'for show' do
    it 'should render show' do
      session[:user_id] = user.id
      user.task = task
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:task)).to be_a_new(Task)
      expect(assigns(:current_user)).to eq(user)
      expect(flash[:notice]).to eq(nil)
    end
   it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:user_id] = user.id
      get :edit, id: task.id
      user.task = task
      expect(response).to render_template(:edit)
      expect(assigns(:task)).to eq(task)
      expect(assigns(:current_user)).to eq(user)
    end
    it 'should redirect to user login' do
      get :edit, id: task.id
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do create' do
    it 'should get task create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :task => { description: 'example' }
      expect(Task.last.description).to eq('example')
      expect(response).to redirect_to(user_url(user.id))
      expect(flash[:notice]).to eq(I18n.t('tasks.task created'))
    end
    it 'should get task create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :task => { description: nil }
      expect(response).to render_template(:new)
    end
  end

  context 'should do update' do
    it 'should get task update success' do
      user.task = task
      session[:user_id] = user.id
      post :update, id: task.id, :task => { description: 'example' }
      expect(task.reload.description).to eq('example')
      expect(flash[:notice]).to eq(I18n.t('tasks.task updated'))
      expect(response.status).to eq(302)
    end
    it 'should get task update error' do
      user.task = task
      task_description = task.description
      session[:user_id] = user.id
      post :update, id: task.id, :task => { description: nil }, format: :js
      expect(task.description).to eq(task_description)
    end
  end

  context 'should do refresh_part' do
    it 'refresh_part' do
      user.task = task
      session[:user_id] = user.id
      post :refresh_part, format: :js
      expect(response).to render_template(partial: 'tasks/_refresh_part')
    end
  end
end