require "test_helper"

class DangkyControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dangky_new_url
    assert_response :success
  end

  test "should get create" do
    get dangky_create_url
    assert_response :success
  end
end
