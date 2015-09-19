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

require 'rails_helper'

RSpec.describe Setting, type: :model do

  it "will not create a Setting without a school" do
  	a = FactoryGirl.build(:setting)
  	a.school = nil
  	expect(a.valid?).to eq false
  end

  it "will not create a Setting without a key" do
  	a = FactoryGirl.build(:setting)
  	a.key = nil
  	expect(a.valid?).to eq false
  end

  it "will not create a Setting without a value" do
  	a = FactoryGirl.build(:setting)
  	a.value = nil
  	expect(a.valid?).to eq false
  end

  it "will create a Setting with required fields" do
  	a = FactoryGirl.build(:setting)
  	expect(a.valid?).to eq true
  end
end
