class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :admin, index: true
      t.string :name
      t.string :password_digest
      t.string :vk_id

      t.timestamps null: false
    end
  end
end
