require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "visitor_information" do
    mail = UserMailer.visitor_information
    assert_equal "Visitor information", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
