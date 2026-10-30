require "test_helper"

class PassengerMailerTest < ActionMailer::TestCase
  test "new" do
    mail = PassengerMailer.new
    assert_equal "New", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "info@metroidhunter.org" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
