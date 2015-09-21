class UserMailer < ActionMailer::Base
  default from: 'noreply@gradery.com'

  def welcome_email(honorific, name, email, password)
    @name = name
    @honorific = honorific
    @password = password
    mail(to: email, subject: 'Gradery Counselor Checkin: You\'ve been added to a school')
  end
end
