class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :task, index: true
      t.string :text

      t.timestamps null: false
    end
  end
end
