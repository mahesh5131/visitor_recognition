class UserMailer < ApplicationMailer
  default from: "622518104301@selvamtech.edu.in"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.visitor_information.subject
  #
  def visitor_information(visitor_tables)
    @visitor_tables=visitor_tables
    mail to: users.email, subject: "Visitor information"
  end
end
