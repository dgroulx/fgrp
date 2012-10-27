require 'test_helper.rb'

class AdminCanAuthenticateTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
  end

  test 'admin can login and logout' do
    admin = users(:administrator)
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password'
    save_and_open_page
    debugger
    click_button 'Sign in'
    assert page.has_content?("Dashboard"), "Admin was unable to log in"
    click_link "Sign Out"
    # Should get redirected to the sign in page
    assert page.has_content?("Sign in")  
  end

  test 'user can not access the admin page without logging in' do
    visit new_admin_park_path
    assert page.has_content?("Sign in"), "Visitor was not redirected to the login page" 
  end
end
