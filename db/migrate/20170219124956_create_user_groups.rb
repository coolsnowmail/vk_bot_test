class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.belongs_to :user, index: true
      t.string :description
      t.string :url

      t.timestamps null: false
    end
  end
end
