require "rails_helper"

RSpec.describe MessageGroup, :type => :model do

  describe 'validations' do
    it { should belong_to :task }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_length_of(:vk_id).is_at_most(30) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:vk_id) }
    it { should have_many(:key_words).dependent(:destroy) }
  end

  let!(:message_group) { create(:message_group) }
  let!(:key_word1) { create(:key_word) }
  let!(:key_word2) { create(:key_word) }
  it 'should get key words' do
    message_group.key_words << key_word1
    message_group.key_words << key_word2
    expect(message_group.take_key_words).to eq(['word', 'word'])
  end
end
