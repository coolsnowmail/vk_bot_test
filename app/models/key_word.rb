# by these words vk user is reserched for semd message
class KeyWord < ActiveRecord::Base
  belongs_to :message_group
  validates :word, presence: true
  validates :word, length: { maximum: 30 }
end
