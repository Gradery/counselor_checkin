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
  before(:all) do
    @s = FactoryGirl.create(:school)
  end

  it "will not create a Setting without a school" do
  	a = Setting.new
  	a.key = "key"
  	a.value = "val"
  	expect(a.valid?).to eq false
  end

  it "will not create a Setting without a key" do
  	a = Setting.new
  	a.school = @s
  	a.value = "val"
  	expect(a.valid?).to eq false
  end

  it "will not create a Setting without a value" do
  	a = Setting.new
  	a.school = @s
  	a.key = "key"
  	expect(a.valid?).to eq false
  end

  it "will create a Setting with required fields" do
  	a = Setting.new
  	a.school = @s
  	a.key = "key"
  	a.value = "val"
  	expect(a.valid?).to eq true
  end
end
