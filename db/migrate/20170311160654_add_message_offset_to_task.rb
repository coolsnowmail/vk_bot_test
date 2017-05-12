class AddMessageOffsetToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :message_offset, :integer, default: 0
  end
end
