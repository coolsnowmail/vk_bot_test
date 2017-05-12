require "rails_helper"


RSpec.describe AdminsController, :type => :controller do

  let!(:admin) { create(:admin) }
  context 'show' do
    it 'render show with admin session' do
      session[:admin_id] = admin.id
      get :show, id: admin.id
      expect(response).to render_template(:show)
    end

    it 'render admin_login_url without admin session' do
      get :show, id: admin.id
      expect(response).to redirect_to(admin_login_url)
    end
  end

  context 'edit' do
    it 'render edit with admin session' do
      session[:admin_id] = admin.id
      get :edit, id: admin.id
      expect(response).to render_template(:edit)
    end

    it 'render admin_login_url without admin session' do
      get :show, id: admin.id
      expect(response).to redirect_to(admin_login_url)
    end
  end

  context 'update' do
    it 'should redirect_to admin_path' do
      session[:admin_id] = admin.id
      post :update, id: admin.id, :admin => { name: 'title0', password: '1234', password_confirmation: '1234', vk_id: '13465464' }
      expect(response).to redirect_to(assigns(:admin))
    end

    it 'should render edit' do
      session[:admin_id] = admin.id
      post :update, id: admin.id, :admin => { name: 'title0', password: nil, password_confirmation: nil, vk_id: nil }
      expect(response).to render_template(:edit)
    end
  end
end
