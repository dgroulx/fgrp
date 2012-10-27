require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:admin)
    sign_in users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
     get :new
     assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "new@user.tk", password: "password", password_confirmation: "password" }
    end

    assert_redirected_to admin_users_path
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { email: @user.email }
    assert_redirected_to admin_users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to admin_users_path
  end
end
