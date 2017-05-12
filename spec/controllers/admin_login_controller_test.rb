require "rails_helper"


RSpec.describe AdminLoginController, :type => :controller do

  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  context 'admin login new' do
    it 'should redirect_to admin_path' do
      session[:admin_id] = admin.id
      get :new
      expect(response).to redirect_to(admin_path(admin.id))
    end

    it 'should redirect user_url' do
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to(user_path(user.id))
      expect(flash[:notice]).to eq(I18n.t('user notes'))
    end
  end

  context 'admin login create' do
    it 'should redirect_to admin_login_url' do
      get :create
      expect(response).to redirect_to(admin_login_url)
      expect(flash[:alert]).to eq(I18n.t('wrong login or password'))
    end

    it 'should redirect_to admin' do
      get :create, name: admin.name, password: admin.password
      expect(response).to redirect_to(admin_path(admin.id))
    end
  end

  context 'admin login destroy' do
    it 'should redirect_to admin_path' do
      session[:admin_id] = admin.id
      get :destroy
      expect(response).to redirect_to(login_url)
      expect(flash[:alert]).to eq(I18n.t('exit done'))
      expect(session[:admin_id]).to eq(nil)
    end
  end
end
