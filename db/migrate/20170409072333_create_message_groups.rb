class CreateMessageGroups < ActiveRecord::Migration
  def change
    create_table :message_groups do |t|
      t.belongs_to :task, index: true
      t.string :vk_id
      t.string :name

      t.timestamps null: false
    end
  end
end
