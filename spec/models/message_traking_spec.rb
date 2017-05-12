require "rails_helper"

RSpec.describe MessageTraking, :type => :model do
  describe 'validations' do
    it { should belong_to :task }
  end
end
