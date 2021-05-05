require 'test_helper'

class OrderLineTest < ActiveSupport::TestCase
  test "create order_line blank attr" do
    assert_not OrderLine.new().valid?
  end
end
