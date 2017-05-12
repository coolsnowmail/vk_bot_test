class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :task, index: true
      t.string :url

      t.timestamps null: false
    end
  end
end
