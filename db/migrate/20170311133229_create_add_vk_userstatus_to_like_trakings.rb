class CreateAddVkUserstatusToLikeTrakings < ActiveRecord::Migration
  def change
      add_column :like_trakings, :vk_user_status, :integer, default: 1
  end
end
