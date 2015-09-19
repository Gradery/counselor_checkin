require 'rails_helper'

RSpec.describe User, type: :model do
  it "will not create a User without a password" do
  	a = User.new
  	a.email = "test@email.com"
  	expect(a.valid?).to eq false
  end
end
