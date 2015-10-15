require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:mail) {UserMailer.welcome_email("Mr","Test User","test@test.com", "12345")}
  it "render correct subject" do
  	expect(mail.subject).to eq 'Gradery Counselor Checkin: You\'ve been added to a school'
  end

end
