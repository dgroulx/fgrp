require 'test_helper'

class Admin::AmenitiesControllerTest < ActionController::TestCase
  setup do
    @amenity = amenities(:playground)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
     get :new
     assert_response :success
  end

  test "should create amenity" do
    assert_difference('Amenity.count') do
      post :create, amenity: { name: @amenity.name }
    end

    assert_redirected_to admin_amenities_path
  end

  test "should get edit" do
    get :edit, id: @amenity
    assert_response :success
  end

  test "should update amenity" do
    put :update, id: @amenity, amenity: { name: @amenity.name }
    assert_redirected_to admin_amenities_path
  end

  test "should destroy amenity" do
    assert_difference('Amenity.count', -1) do
      delete :destroy, id: @amenity
    end

    assert_redirected_to admin_amenities_path
  end
end
