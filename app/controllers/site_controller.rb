require 'net/http'

class SiteController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_admin

  def landing
    @client = Client.new
  end

  def sending
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        return render partial: 'success_save'
      else
        return render partial: 'fail_save'
      end
      # if @client = @client.save
      #   format.html { redirect_to landing_path, notice: 'Запись на урок прошла успешно. Учитель свяжусь с Вами в ближайшее время' }
      # else
      #   format.html { render :landing }
      # end
    end
  end

  private

    def client_params
      params.require(:client).permit(:name, :level, :phone)
    end
end