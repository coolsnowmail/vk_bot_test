class SessionsController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_admin

  def new
    redirect_to user_path(session[:user_id]) if session[:user_id]
    redirect_to admin_path(session[:admin_id]), notice: t('user notes') if session[:admin_id]
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(session[:user_id])
    else
      redirect_to login_url, alert: t('wrong login or password')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, alert: t('exit done')
  end
end
