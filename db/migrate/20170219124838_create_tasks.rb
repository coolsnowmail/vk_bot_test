class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.string :description

      t.timestamps null: false
    end
  end
end
