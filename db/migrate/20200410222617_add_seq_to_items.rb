class AddSeqToItems < ActiveRecord::Migration[6.0]
  def change
  	add_column :items, :seq, :int
  	remove_column :items, :added_at
  end
end
