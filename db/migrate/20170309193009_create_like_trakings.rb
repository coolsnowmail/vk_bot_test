class CreateLikeTrakings < ActiveRecord::Migration
  def change
    create_table :like_trakings do |t|
      t.string :vk_user_id
      t.integer :offset
      t.string :vk_group_id
      t.integer :bot_id
      t.belongs_to :task, index: true

      t.timestamps null: false
    end
  end
end
