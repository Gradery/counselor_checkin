# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :text
#  school_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Setting < ActiveRecord::Base
	belongs_to :school
   	validates :school, :key, :value, presence: true, allow_nil: false, allow_blank: false

end
