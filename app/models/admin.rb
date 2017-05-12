# site admin
class Admin < ActiveRecord::Base
  has_secure_password
  has_many :users
  validates :name, :vk_id, :password, presence: true
  before_destroy :check_if_last_admin
  validates :vk_id, numericality: :only_integer
  validates :name, length: { maximum: 30 }

  def check_if_last_admin
    return false if Admin.all.size <= 2
  end
end
