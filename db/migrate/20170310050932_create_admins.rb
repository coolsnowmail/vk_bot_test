class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.string :password_digest
      t.string :vk_id

      t.timestamps null: false
    end
  end
end
