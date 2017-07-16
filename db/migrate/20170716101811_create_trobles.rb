class CreateTrobles < ActiveRecord::Migration
  def change
    create_table :trobles do |t|
      t.integer :client_type
      t.belongs_to :client, index: true

      t.timestamps null: false
    end
  end
end
