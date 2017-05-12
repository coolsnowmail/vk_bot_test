# vk user's group
class UserGroup < ActiveRecord::Base
  belongs_to :user
  validates :description, presence: true
  validates :url, presence: true
  validates :description, length: { maximum: 18 }
  validates :url, length: { maximum: 55 }
  validates :url, numericality: :only_integer
end
