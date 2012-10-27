require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  def setup
    sign_in users(:admin)
  end
    
  test "should get index" do
    get :index
    assert_response :success
  end
end
