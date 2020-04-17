# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  list_id    :uuid
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  seq        :integer
#
class Item < ApplicationRecord
	belongs_to :list
end
