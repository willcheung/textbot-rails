class CreateItems < ActiveRecord::Migration[6.0]
  def change
  	create_table :items do |t|
      t.uuid :list_id, index: true
      t.string :name
      t.timestamp :added_at

      t.timestamps null: false
    end
  end
end
