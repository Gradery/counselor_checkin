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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checkin do
    name "MyString"
    is_student false
    badge_id "MyString"
    child_name "MyString"
    user
    custom_reason false
    reason
    reason_text "MyText"
  end
end
