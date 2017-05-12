# tracks all like was made
class LikeTraking < ActiveRecord::Base
  belongs_to :task
  enum vk_user_status: { 'Empty' => 3, 'Banned' => 2, 'Normal' => 1 }
  validates :vk_user_status, inclusion: { in: LikeTraking.vk_user_statuses.keys }
end
