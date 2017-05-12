require 'rails_helper'

RSpec.describe ActivateBotController, type: :routing do
  describe 'routing' do

    it 'routes to #activate' do
      expect(get: '/activate_bot/activate').to route_to('activate_bot#activate')
    end
  end
end
