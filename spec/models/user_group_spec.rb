require "rails_helper"

RSpec.describe UserGroup, :type => :model do

  describe 'validations' do
    it { should belong_to :user }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:url) }
    it { should validate_length_of(:description).is_at_most(18) }
    it { should validate_length_of(:url).is_at_most(55) }
    it { should validate_numericality_of(:url) }
  end
end
