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
#  school_id              :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @s = FactoryGirl.create(:school)
  end

  it "will not create a User without a password" do
  	a = User.new
  	a.email = "test@email.com"
    a.name = "asdf"
    a.school = @s
    a.is_admin = false
  	expect(a.valid?).to eq false
  end

  it "will not create a User with a password less than 8 characters" do
  	a = User.new
  	a.email = "test@email.com"
  	a.password = "1234567"
    a.name = "asdf"
    a.school = @s
    a.is_admin = false
  	expect(a.valid?).to eq false
  end

  it "will not create a User without an email" do
  	a = User.new
  	a.password = "something"
    a.name = "asdf"
    a.school = @s
    a.is_admin = false
  	expect(a.valid?).to eq false
  end

  it "will not create a User without a valid email structure" do
  	a = User.new
  	a.password = "something"
  	a.email = "not-an-email"
    a.name = "asdf"
    a.school = @s
    a.is_admin = false
  	expect(a.valid?).to eq false
  end

  it "will not create a User without a name" do
    a = User.new
    a.password = "something"
    a.email = "test@email.com"
    a.school = @s
    a.is_admin = false
    expect(a.valid?).to eq false
  end

  it "will not create a User without a school" do
    a = User.new
    a.password = "something"
    a.email = "test@email.com"
    a.name = "name"
    a.is_admin = false
    expect(a.valid?).to eq false
  end

  it "will create a User with valid fields" do
  	a = User.new
  	a.password = "12345678"
  	a.email = "test@email.com"
    a.name = "name"
    a.school = @s
    a.is_admin = false
  	expect(a.valid?).to eq true
  end

end
