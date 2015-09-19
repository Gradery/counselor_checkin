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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reason do
    school
    text "MyText"
  end
end
