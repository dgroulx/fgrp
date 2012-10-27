require 'test_helper.rb'

class AdminCanAuthenticateTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
    @admin = users(:admin)
  end

  test 'admin can login and logout' do
    sign_in(@admin.email, 'password')
    assert page.has_content?(@admin.email), "Admin was unable to log in"
    click_link "Sign Out"
    # Should get redirected to the sign in page
    assert page.has_content?("Sign in"), "Admin did not log out" 
  end

  test 'user can not access the admin page without logging in' do
    visit new_admin_park_path
    assert page.has_content?("Sign in"), "Visitor was not redirected to the login page" 
  end
end
