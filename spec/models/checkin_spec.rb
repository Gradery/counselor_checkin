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

require 'rails_helper'

RSpec.describe Checkin, type: :model do
  it "will not create a Checkin without a name" do
  	c = FactoryGirl.create(:checkin)
  	c.name = nil
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin without a badge_id if it is a student checking in" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = true
  	c.badge_id = nil
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin with a blank badge_id if it is a student checking in" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = true
  	c.badge_id = ""
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin without a child_name if it is a parent checking in" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = false
  	c.child_name = nil
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin with a blank child_name if it is a parent checking in" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = false
  	c.child_name = ""
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin without a reason if custom_reason == true" do
  	c = FactoryGirl.create(:checkin)
  	c.custom_reason = true
  	c.reason_text = nil
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin with a blank reason if custom_reason == true" do
  	c = FactoryGirl.create(:checkin)
  	c.custom_reason = true
  	c.reason_text = ""
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin without a reason if custom_reason == true" do
  	c = FactoryGirl.create(:checkin)
  	c.custom_reason = true
  	c.reason_text = nil
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin without a reason if custom_reason == false" do
  	c = FactoryGirl.create(:checkin)
  	c.custom_reason = false
  	c.reason = nil
  	expect(c.valid?).to eq false
  end

  it "will not create a Checkin without a user (counselor)" do
    c = FactoryGirl.create(:checkin)
    c.user = nil
    expect(c.valid?).to eq false
  end

  it "will create a checkin with all fields filled for a child with a set reason" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = true
  	c.custom_reason = false
  	expect(c.valid?).to eq true
  end

  it "will create a checkin with all fields filled for a child with a custom reason" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = true
  	c.custom_reason = true
  	expect(c.valid?).to eq true
  end

  it "will create a checkin with all fields filled for a parent with a set reason" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = false
  	c.custom_reason = false
  	expect(c.valid?).to eq true
  end

  it "will create a checkin with all fields filled for a parent with a custom reason" do
  	c = FactoryGirl.create(:checkin)
  	c.is_student = false
  	c.custom_reason = true
  	expect(c.valid?).to eq true
  end
end
