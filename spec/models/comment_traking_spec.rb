require "rails_helper"

RSpec.describe CommentTraking, :type => :model do
  describe 'validations' do
    it { should belong_to :task }
  end
end
