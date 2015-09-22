# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  is_admin               :boolean
#  school_id              :integer
#  honorific              :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  it "will not create a User without a password" do
  	a = FactoryGirl.build(:user)
    a.password = nil
  	expect(a.valid?).to eq false
  end

  it "will not create a User with a password less than 8 characters" do
  	a = FactoryGirl.create(:user)
    a.password = "1234567"
  	expect(a.valid?).to eq false
  end

  it "will not create a User without an email" do
  	a = FactoryGirl.create(:user)
    a.email = nil
  	expect(a.valid?).to eq false
  end

  it "will not create a User without a valid email structure" do
  	a = FactoryGirl.create(:user)
    a.email = "sdfsdfs"
  	expect(a.valid?).to eq false
  end

  it "will not create a User without a name" do
    a = FactoryGirl.create(:user)
    a.name = nil
    expect(a.valid?).to eq false
  end

  it "will not create a User without a school" do
    a = FactoryGirl.create(:user)
    a.school = nil
    expect(a.valid?).to eq false
  end

  it "will not create a User without an honorific" do
    a = FactoryGirl.create(:user)
    a.honorific = nil
    expect(a.valid?).to eq false
  end

  it "will create a User with valid fields" do
  	a = FactoryGirl.create(:user)
  	expect(a.valid?).to eq true
  end

end
