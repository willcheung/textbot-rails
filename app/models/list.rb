# == Schema Information
#
# Table name: lists
#
#  id              :uuid             not null, primary key
#  name            :string
#  description     :text
#  limit           :integer
#  is_active       :boolean          default("true")
#  owner_id        :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class List < ApplicationRecord
	#has_many :customers
	has_many :items
	belongs_to :user, foreign_key: :owner_id

	def update_seq_column
		query = <<-SQL
			UPDATE items
			SET    seq = t.rn
			FROM  (select id, (row_number() over (partition by list_id order by seq)) rn from items) t
			WHERE  items.id = t.id
			AND list_id='#{self.id}';
  	SQL
		ActiveRecord::Base.connection.execute(query)
	end
end
