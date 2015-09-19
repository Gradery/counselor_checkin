require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it "will not create an AdminUser without a password" do
  	a = AdminUser.new
  	a.email = "test@email.com"
  	expect(a.valid?).to eq false
  end
end
