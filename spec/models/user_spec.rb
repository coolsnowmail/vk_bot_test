require "rails_helper"


RSpec.describe User, :type => :model do

  describe 'validations' do
    it { should belong_to :admin }
    it { should have_one(:user_group).dependent(:destroy) }
    it { should have_one(:task).dependent(:destroy) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:vk_id) }
    it { should validate_numericality_of(:vk_id) }
    it { should validate_length_of(:name).is_at_most(30) }
  end

  context 'should check count methods of user' do
    let!(:user) { create(:user) }
    let!(:task) { create(:task) }
    let!(:like_traking1) { create(:like_traking) }
    let!(:like_traking2) { create(:like_traking) }
    let!(:message_traking1) { create(:message_traking) }
    let!(:message_traking2) { create(:message_traking) }
    let!(:comment_traking1) { create(:comment_traking) }
    let!(:comment_traking2) { create(:comment_traking) }

    it 'should return like count' do
      user.task = task
      user.save
      task.update(user_id: user.id)
      task.like_trakings << like_traking1
      task.like_trakings << like_traking2
      expect(user.like_count).to eq(2)
    end

    it 'should return message count' do
      user.task = task
      user.save
      task.update(user_id: user.id)
      task.message_trakings << message_traking1
      task.message_trakings << message_traking2
      expect(user.message_count).to eq(2)
    end

    it 'should return comment count' do
      user.task = task
      user.save
      task.update(user_id: user.id)
      task.comment_trakings << comment_traking1
      task.comment_trakings << comment_traking2
      expect(user.comment_count).to eq(2)
    end
  end
end