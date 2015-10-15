# == Schema Information
#
# Table name: reasons
#
#  id         :integer          not null, primary key
#  school_id  :integer
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

class Reason < ActiveRecord::Base
	validates :school, :text, presence: true, allow_nil: false, allow_blank: false

	belongs_to :school

   	has_and_belongs_to_many :users

	def name
		text
	end
end
