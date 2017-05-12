require "rails_helper"


RSpec.describe CommentsController, :type => :controller do

  let!(:bot) { create(:bot) }
  let!(:user) { create(:user) }
  let!(:task) { create(:task) }
  let!(:comment) { create(:comment) }
  let!(:comment1) { create(:comment) }
  let!(:message_group) { create(:message_group) }
  let!(:key_word) { create(:key_word) }
  context 'for index' do
    it 'should render index' do
      session[:user_id] = user.id
      user.task = task
      task.comments << comment
      task.comments << comment1
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:comments)).to eq(user.task.comments)
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
      expect(assigns(:comment)).to be_a_new(Comment)
    end
    it 'should redirect to user login' do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  context 'for edit' do
    it 'should render edit' do
      session[:user_id] = user.id
      get :edit, id: comment.id
      expect(response).to render_template(:edit)
      expect(assigns(:comment)).to eq(comment)
    end
    it 'should redirect to user login' do
      get :edit, id: comment.id
      expect(response).to redirect_to(login_url)
    end
  end

  context 'should do create' do
    it 'should get comment create success' do
      user.task = task
      session[:user_id] = user.id
      post :create, :comment => { text: 'j4655578 fsddfsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds'}
      expect(Comment.last.text).to eq('j4655578 fsddfsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds')
      expect(response).to redirect_to(comments_path)
      expect(flash[:notice]).to eq(I18n.t('comments.was successfully created'))
    end
    it 'should get comment create error' do
      user.task = task
      session[:user_id] = user.id
      post :create, :comment => { text: nil }
      expect(response).to render_template(:new)
    end
  end

context 'should do update' do
  it 'should get comment update success' do
    user.task = task
    session[:user_id] = user.id
    post :update, id: comment.id, :comment => { text: 'fsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds' }
    expect(comment.reload.text).to eq('fsdfsd fsdfdsfdsfdsfsd f fsdfsdfdsfsdfsdfsd s fdsfsdfdsfds')
    expect(response).to redirect_to(comments_path)
    expect(flash[:notice]).to eq(I18n.t('comments.was successfully updated'))
  end
  it 'should get comment update error' do
    user.task = task
    session[:user_id] = user.id
    post :update, id: comment.id, :comment => { text: '' }
    expect(response).to render_template(:edit)
  end
end

  context 'should do destroy' do
    it 'should get bot update success' do
      user.task = task
      session[:user_id] = user.id
      delete :destroy, id: comment.id, format: :js
      expect(assigns(:comment).destroyed?).to eq(true)
    end
  end
end