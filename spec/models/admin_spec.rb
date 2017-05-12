require "rails_helper"


RSpec.describe Admin, :type => :model do

  describe 'validations' do
    it { should have_many :users }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:vk_id) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_numericality_of(:vk_id) }
  end

  context 'should cancel delete of admin' do
    let!(:admin1) { create(:admin) }
    let!(:admin2) { create(:admin) }
    let!(:admin3) { create(:admin) }
    it 'should delete admin' do
      admin1.delete
      expect(Admin.all.size).to eq(2)
    end

    it 'should check to not alow delete admin if admins <= 2' do
      admin1.destroy
      admin2.destroy
      expect(Admin.all.size).to eq(2)
    end
  end
end
