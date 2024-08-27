require "test_helper"

class MaisonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get maisons_index_url
    assert_response :success
  end
end
