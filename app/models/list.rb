# == Schema Information
#
# Table name: lists
#
#  id              :uuid             not null, primary key
#  name            :string
#  short_name      :string
#  description     :text
#  limit           :integer
#  is_active       :boolean          default("true")
#  organization_id :uuid
#  owner_id        :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class List < ApplicationRecord
	#has_many :customers
	has_many :items
	belongs_to :user, foreign_key: :owner_id
end
