class Visitor < ApplicationRecord
  after_create :send_mail_to_owner

  def send_mail_to_owner
    UserMailer.visitor_information(self).deliver_now
  end
end
