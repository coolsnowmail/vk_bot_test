require "rails_helper"


RSpec.describe KeyWord, :type => :model do

  describe 'validations' do
    it { should belong_to :message_group }
    it { should validate_presence_of(:word) }
    it { should validate_length_of(:word).is_at_most(30) }
  end
end
