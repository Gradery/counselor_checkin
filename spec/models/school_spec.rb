# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  url        :string(255)
#

require 'rails_helper'
require 'faker'
RSpec.describe School, type: :model do
  it "will not create a School without a name" do
  	a = FactoryGirl.create(:school)
  	a.name = nil
  	expect(a.valid?).to eq false
  end

  it "will not create a School with a blank name" do
  	a = FactoryGirl.create(:school)
  	a.name = ""
  	expect(a.valid?).to eq false
  end

  it "will not create a School without a url" do
  	a = FactoryGirl.create(:school)
  	a.url = nil
  	expect(a.valid?).to eq false
  end

  it "will create a School if the url isn't unique" do
  	a = FactoryGirl.create(:school)
  	b = FactoryGirl.build(:school)
  	b.url = a.url
  	expect(b.valid?).to eq false
  end

  it "will create a School with a name and unique url" do
  	a = FactoryGirl.create(:school)
  	expect(a.valid?).to eq true
  end
end
