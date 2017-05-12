require "rails_helper"

RSpec.describe LikeTraking, :type => :model do
  describe 'validations' do
    it { should belong_to :task }
    it do
      should define_enum_for(:vk_user_status).with({ "Empty" => 3, "Banned" => 2, "Normal" => 1 })
    end
  end
end
