# user model
class User < ActiveRecord::Base
  has_secure_password
  belongs_to :admin
  has_one :user_group, dependent: :destroy
  has_one :task, dependent: :destroy
  validates :name, :password, :vk_id, presence: true
  validates :vk_id, numericality: :only_integer
  validates :name, length: { maximum: 30 }

  def like_count
    task.like_trakings.count
  end

  def comment_count
    task.comment_trakings.count
  end

  def message_count
    task.message_trakings.count
  end
end
