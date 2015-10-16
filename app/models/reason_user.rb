# == Schema Information
#
# Table name: reasons_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  reason_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class ReasonUser < ActiveRecord::Base

	self.table_name =  "reasons_users"

	belongs_to :user
	belongs_to :reason
end
