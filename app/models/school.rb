# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class School < ActiveRecord::Base
	has_many :settings
	has_many :users
	has_many :reasons
	has_many :checkins

	validates :name, presence: true
end
