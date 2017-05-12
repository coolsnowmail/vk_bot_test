require "rails_helper"


RSpec.describe Bot, :type => :model do

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(18) }
    it { should validate_length_of(:access_token).is_at_least(18).is_at_most(180) }
    it { should allow_value("", nil).for(:access_token) }
    it { should belong_to :task }
    it do
      should define_enum_for(:status).with({ "Not Active" => 1, "Pending" => 2, "Active" => 3 })
    end
  end

  let!(:task) { create(:task) }
  let!(:bot) { create(:bot) }
  let!(:like_traking) { create(:like_traking) }
  let!(:like_traking2) { create(:like_traking) }
  let!(:message_traking) { create(:message_traking) }
  let!(:message_traking2) { create(:message_traking) }
  let!(:comment_traking) { create(:comment_traking) }
  let!(:comment_traking2) { create(:comment_traking) }
  let!(:group) { create(:group) }
  context 'should check offset_change method ' do
    it 'should return 0' do
      task.bots << bot
      expect(bot.offset_change).to eq(0)
    end
    it 'should return 13' do
      task.bots << bot
      task.like_trakings << like_traking
      like_traking.update(bot_id: bot.id)
      expect(bot.offset_change).to eq(13)
    end
  end

  it 'should check if_members_over method' do
    task.groups << group
    task.bots << bot
    task.like_trakings << like_traking
    like_traking.update(bot_id: bot.id)
    bot.if_members_over(1)
    expect(Group.all.size).to eq(0)
  end

  it 'should check check_like_limit method' do
    task.like_trakings << like_traking
    task.bots << bot
    like_traking.update(bot_id: bot.id)
    expect(bot.check_like_limit).to eq(1)
  end

  it 'should check check_if_like_have_maked method' do
    task.groups << group
    task.like_trakings << like_traking
    task.like_trakings << like_traking2
    task.bots << bot
    like_traking.update(bot_id: bot.id)
    like_traking2.update(bot_id: bot.id)
    like_traking.update(vk_group_id: task.groups.first.url.split('/')[3])
    like_traking2.update(vk_group_id: task.groups.first.url.split('/')[3])
    expect(bot.check_if_like_have_maked.size).to eq(2)
  end

  it 'should check check_like_limit method' do
    task.like_trakings << like_traking
    task.like_trakings << like_traking2
    task.bots << bot
    like_traking.update(bot_id: bot.id)
    like_traking2.update(bot_id: bot.id, created_at: Time.now - 2.days)
    expect(bot.check_like_limit).to eq(1)
  end

  it 'should check check_message_limit method' do
    task.message_trakings << message_traking
    task.message_trakings << message_traking2
    task.bots << bot
    message_traking.update(bot_id: bot.id)
    message_traking2.update(bot_id: bot.id, created_at: Time.now - 2.days)
    expect(bot.check_message_limit).to eq(1)
  end

  it 'should check check_com_limit method' do
    task.comment_trakings << comment_traking
    task.comment_trakings << comment_traking2
    task.bots << bot
    comment_traking.update(bot_id: bot.id)
    comment_traking2.update(bot_id: bot.id, created_at: Time.now - 2.days)
    expect(bot.check_com_limit).to eq(1)
  end

  it 'should check disactive_bot method' do
    bot.update(status: "Active")
    bot.disactive_bot
    expect(bot.status).to eq("Not Active")
  end

  context 'should check if_members_for_messsage_send_over method' do
    it 'should do nothing' do
      task.update(message_offset: 22)
      task.bots << bot
      bot.if_members_for_messsage_send_over(23)
      expect(task.message_offset).to eq(22)
    end

    it 'should reset message_offset' do
      task.update(message_offset: 22)
      task.bots << bot
      bot.if_members_for_messsage_send_over(22)
      expect(task.message_offset).to eq(0)
    end
  end
end
