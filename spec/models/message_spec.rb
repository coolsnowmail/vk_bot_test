require "rails_helper"

RSpec.describe Message, :type => :model do
  describe 'validations' do
    it { should belong_to :task }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(500) }
  end
end
