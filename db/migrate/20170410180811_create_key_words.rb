class CreateKeyWords < ActiveRecord::Migration
  def change
    create_table :key_words do |t|
      t.string :word
      t.belongs_to :message_group, index: true

      t.timestamps null: false
    end
  end
end
