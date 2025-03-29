require "test_helper"

class SharedListsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get shared_lists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get shared_lists_destroy_url
    assert_response :success
  end

  test "should get update" do
    get shared_lists_update_url
    assert_response :success
  end
end
