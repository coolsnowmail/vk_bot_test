require "rails_helper"


RSpec.describe Task, :type => :model do

  describe 'validations' do
    it { should belong_to :user }
    it { should have_one(:message_group).dependent(:destroy) }
    it { should have_many(:like_trakings).dependent(:destroy) }
    it { should have_many(:message_trakings).dependent(:destroy) }
    it { should have_many(:comment_trakings).dependent(:destroy) }
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:groups).dependent(:destroy) }
    it { should have_many(:bots).dependent(:destroy) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(30) }
  end

  context 'should return active bots' do
    let!(:task) { create(:task) }
    let!(:bot1) { create(:bot) }
    let!(:bot2) { create(:bot) }
    let!(:bot3) { create(:bot) }
    it 'should return active bots' do
      task.bots << bot1
      task.bots << bot2
      task.bots << bot3
      bot1.update(status: 3)
      expect(task.any_active_bot?).to eq(true)
    end

    it 'should check to not alow delete admin if admins <= 2' do
      task.bots << bot1
      task.bots << bot2
      task.bots << bot3
      expect(task.any_active_bot?).to eq(false)
    end
  end
end
