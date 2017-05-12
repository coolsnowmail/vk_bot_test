class AdminLoginController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_admin

  def new
    redirect_to admin_path(session[:admin_id]) if session[:admin_id]
    redirect_to user_url(session[:user_id]), notice: t('user notes') if session[:user_id]
  end

  def create
    admin = Admin.find_by(name: params[:name])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_path(session[:admin_id])
    else
      redirect_to admin_login_url, alert: t('wrong login or password')
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_url, alert: t('exit done')
  end
end
