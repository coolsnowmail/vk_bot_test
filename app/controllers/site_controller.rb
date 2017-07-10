require 'net/http'

class SiteController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_admin

  def landing
  end

  def sending
  end
end