require 'test_helper'

class Admin::ParksControllerTest < ActionController::TestCase
  setup do
    @park = parks(:aberdeen)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
     get :new
     assert_response :success
  end

  test "should create park" do
    assert_difference('Park.count') do
      post :create, park: { name: @park.name }
    end

    assert_redirected_to admin_parks_path
  end

  test "should get edit" do
    get :edit, id: @park
    assert_response :success
  end

  test "should update park" do
    put :update, id: @park, park: { name: @park.name }
    assert_redirected_to admin_parks_path
  end

  test "should destroy park" do
    assert_difference('Park.count', -1) do
      delete :destroy, id: @park
    end

    assert_redirected_to admin_parks_path
  end
end
