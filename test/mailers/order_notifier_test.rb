require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Tango Lingo order confirmation", mail.subject
    assert_equal ["michal@formail.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Dear Dave Thomas\r\n\r\nThank you for your recent order from the Tango Lingo store.\r\n\r\nYou ordered the following items:\r\n\r\n 2 x Programming Ruby 1.9\r\n\r\nWe'll give you a heads up, when your order ships." , mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Tango Lingo order shipped!", mail.subject
    assert_equal ["Michal Mottl <from@example.com>"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
