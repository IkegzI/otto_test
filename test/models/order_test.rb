require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "create order blank client" do
    assert_not Order.new().valid?
  end

end
