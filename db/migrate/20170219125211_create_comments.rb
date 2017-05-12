class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :task, index: true
      t.string :text

      t.timestamps null: false
    end
  end
end
