class UserMailer < ApplicationMailer
  default from: 'test@rottentomatoes.com'

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: "You've officially been removed")
  end
end
