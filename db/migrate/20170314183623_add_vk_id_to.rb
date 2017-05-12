class AddVkIdTo < ActiveRecord::Migration
  def change
    add_column :bots, :vk_id, :integer
  end
end
