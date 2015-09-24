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

require 'rails_helper'

RSpec.describe Reason, type: :model do
  it "will not create a Reason without text" do
    r = FactoryGirl.create(:reason)
    r.text = nil
    expect(r.valid?).to eq false
  end

  it "will not create a Reason with blank text" do
    r = FactoryGirl.create(:reason)
    r.text = ""
    expect(r.valid?).to eq false
  end

  it "will not create a Reason without a school" do
  	r = FactoryGirl.create(:reason)
  	r.school = nil
  	expect(r.valid?).to eq false
  end

  it "will create a Reason with all required stuff filled out" do
  	r = FactoryGirl.create(:reason)
  	expect(r.valid?).to eq true
  end

  it "will return the text as the name field" do
    r = FactoryGirl.create(:reason)
    expect(r.name).to eq r.text
  end
end
