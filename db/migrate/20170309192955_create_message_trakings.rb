class CreateMessageTrakings < ActiveRecord::Migration
  def change
    create_table :message_trakings do |t|
      t.string :vk_user_id
      t.integer :message_id
      t.integer :bot_id
      t.belongs_to :task, index: true

      t.timestamps null: false
    end
  end
end
