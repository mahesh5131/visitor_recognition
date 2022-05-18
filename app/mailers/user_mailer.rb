class UserMailer < ApplicationMailer
  default from: "smnmalai@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.visitor_information.subject
  #
  def visitor_information(visitor)
    @visitor = visitor
    user = User.first
    mail to: user.email, subject: "Visitor information"
  end
end
