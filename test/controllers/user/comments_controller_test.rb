require "test_helper"

class User::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get user_comments_edit_url
    assert_response :success
  end
end
