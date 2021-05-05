require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get messages_users_url
    assert_response :success
  end

  test "should get rooms" do
    get messages_rooms_url
    assert_response :success
  end
end
