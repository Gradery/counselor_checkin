# == Schema Information
#
# Table name: checkins
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  is_student    :boolean
#  badge_id      :string(255)
#  child_name    :string(255)
#  user_id       :integer
#  custom_reason :boolean
#  reason_id     :integer
#  reason_text   :text
#  created_at    :datetime
#  updated_at    :datetime
#  school_id     :integer
#

class Checkin < ActiveRecord::Base
	validates :name, presence: true
	validates :badge_id, presence: true, allow_blank: false,allow_nil: false, if: "is_student == true"
	validates :child_name, presence: true, allow_blank: false,allow_nil: false, if: "is_student == false"
	validates :reason, presence: true,allow_nil: false, if: "custom_reason == false"
	validates :reason_text, presence: true, allow_blank: false,allow_nil: false, if: "custom_reason == true"
	validates :user, presence: true, allow_nil: false, allow_blank: false

	belongs_to :reason
	belongs_to :school
	belongs_to :user
end
