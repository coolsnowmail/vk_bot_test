require 'rails_helper'

RSpec.describe KeyWordsController, type: :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(get: '/key_words/new').to route_to('key_words#new')
    end

    it 'routes to #create' do
      expect(post: "/key_words").to route_to('key_words#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/key_words/1').to route_to('key_words#destroy', id: '1')
    end
  end
end
