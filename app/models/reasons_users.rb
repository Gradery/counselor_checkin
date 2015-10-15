# == Schema Information
#
# Table name: users_reasons
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  reason_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class ReasonsUsers < ActiveRecord::Base
	belongs_to :user
	belongs_to :reason
end
