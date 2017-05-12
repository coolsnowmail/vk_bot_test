require "rails_helper"

RSpec.describe Group, :type => :model do

  describe 'validations' do
    it { should belong_to :task }
    it { should validate_length_of(:url).is_at_least(5).is_at_most(40) }
    it { should validate_presence_of(:url) }
    it { should validate_numericality_of(:url) }
  end
end
