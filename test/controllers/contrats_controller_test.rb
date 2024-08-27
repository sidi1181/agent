require "test_helper"

class ContratsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contrats_index_url
    assert_response :success
  end

  test "should get show" do
    get contrats_show_url
    assert_response :success
  end

  test "should get new" do
    get contrats_new_url
    assert_response :success
  end
end
