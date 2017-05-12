require "rails_helper"


RSpec.describe SessionsController, :type => :controller do

  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  context 'session new' do
    it 'should redirect_to user_path' do
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to(user_path(user.id))
    end

    it 'should redirect admin_url' do
      session[:admin_id] = admin.id
      get :new
      expect(response).to redirect_to(admin_path(admin.id))
      expect(flash[:notice]).to eq(I18n.t('user notes'))
    end
  end

  context 'user login create' do
    it 'should redirect_to login_url' do
      get :create
      expect(response).to redirect_to(login_url)
      expect(flash[:alert]).to eq(I18n.t('wrong login or password'))
    end

    it 'should redirect_to user' do
      get :create, name: user.name, password: user.password
      expect(response).to redirect_to(user_path(user.id))
    end
  end

  context 'user login destroy' do
    it 'should redirect_to user_path' do
      session[:user_id] = user.id
      get :destroy
      expect(response).to redirect_to(login_url)
      expect(flash[:alert]).to eq(I18n.t('exit done'))
      expect(session[:user_id]).to eq(nil)
    end
  end
end