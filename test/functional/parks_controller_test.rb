require 'test_helper'

class ParksControllerTest < ActionController::TestCase
  setup do
    @park = parks(:aberdeen)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should show park" do
    get :show, id: @park
    assert_response :success
    assert_equal 4, assigns(:facts).count, "Park#show should include 4 facts"
  end
end
