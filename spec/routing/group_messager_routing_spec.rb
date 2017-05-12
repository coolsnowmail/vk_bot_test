require 'rails_helper'

RSpec.describe GroupMessagerController, type: :routing do
  describe 'routing' do


    it 'routes to #new' do
      expect(get: '/group_messager/new').to route_to('group_messager#new')
    end

    it 'routes to #edit' do
      expect(get: '/group_messager/1/edit').to route_to('group_messager#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/group_messager').to route_to('group_messager#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/group_messager/1').to route_to('group_messager#update', id: '1')
   end

    it 'routes to #update via PATCH' do
      expect(patch: '/group_messager/1').to route_to('group_messager#update', id: '1')
    end
  end
end
