require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test "create client blank all attr" do
    assert_not Client.new().valid?
  end
  test "create client blank number" do
    assert_not Client.new(firstname: 'a', lastname: 'f', post_index: 664000).valid?
  end
  test "create client blank firstname" do
    assert_not Client.new(firstname: '123', lastname: 'f', post_index: 664000).valid?
  end
  test "create client blank post_index" do
    assert_not Client.new(firstname: '123', lastname: 'f', number: 664000).valid?
  end
end
