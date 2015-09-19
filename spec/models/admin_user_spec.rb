# == Schema Information
#
# Table name: admin_users
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
#

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it "will not create a AdminUser without a password" do
  	a = AdminUser.new
  	a.email = "test@email.com"
  	expect(a.valid?).to eq false
  end

  it "will not create a AdminUser with a password less than 8 characters" do
  	a = AdminUser.new
  	a.email = "test@email.com"
  	a.password = "1234567"
  	expect(a.valid?).to eq false
  end

  it "will not create a AdminUser without an email" do
  	a = AdminUser.new
  	a.password = "something"
  	expect(a.valid?).to eq false
  end

  it "will not create a AdminUser without a valid email structure" do
  	a = AdminUser.new
  	a.password = "something"
  	a.email = "not-an-email"
  	expect(a.valid?).to eq false
  end

  it "will create a AdminUser with a valid email and password" do
  	a = AdminUser.new
  	a.password = "12345678"
  	a.email = "test@email.com"
  	expect(a.valid?).to eq true
  end
end
