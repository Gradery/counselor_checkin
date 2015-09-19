# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'
require 'faker'
RSpec.describe School, type: :model do
  it "will not create a School without a name" do
  	a = School.new
  	expect(a.valid?).to eq false
  end

  it "will create a School with a name" do
  	a = School.new
  	a.name = Faker::Company.name
  	expect(a.valid?).to eq true
  end
end
