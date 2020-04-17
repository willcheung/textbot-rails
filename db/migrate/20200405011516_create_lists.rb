class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists, id: :uuid do |t|
    	t.string 	:name
    	t.string	:short_name 								#unique
    	t.text		:description
    	t.integer :limit
      t.boolean	:is_active, default: true
      t.uuid		:organization_id
      t.uuid		:owner_id

      t.timestamps
    end

    add_index :lists, :short_name, unique: true
  end
end
