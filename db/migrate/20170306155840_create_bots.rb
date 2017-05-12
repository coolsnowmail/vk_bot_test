class CreateBots < ActiveRecord::Migration
  def change
    create_table :bots do |t|
      t.belongs_to :task, index: true
      t.string :description
      t.string :login_vk
      t.string :password_vk
      t.string :access_token
      t.integer :status, default: 1

      t.timestamps null: false
    end
  end
end
