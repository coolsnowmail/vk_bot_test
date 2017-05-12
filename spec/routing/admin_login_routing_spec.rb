require 'rails_helper'

RSpec.describe AdminLoginController, type: :routing do
  describe 'routing' do


    it 'routes to #admin_login#new' do
      expect(get: '/admin_login').to route_to('admin_login#new')
    end

    it 'routes to #admin_login#create' do
      expect(post: '/admin_login').to route_to('admin_login#create')
    end

    it 'routes to #admin_login#destroy' do
      expect(delete: '/admin_logout').to route_to('admin_login#destroy')
    end

  end
end
