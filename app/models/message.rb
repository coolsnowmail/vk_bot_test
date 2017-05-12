# message that sends bots to vk users
class Message < ActiveRecord::Base
  belongs_to :task
  validates :text, presence: true
  validates :text, length: { maximum: 500 }
end
