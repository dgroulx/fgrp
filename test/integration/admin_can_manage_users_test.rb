require 'test_helper'

class AdminCanManageUsersTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.current_driver = Capybara.javascript_driver
    @admin = users(:admin)
    @user = users(:user)
  end

  test 'admin can create a user' do
    sign_in(@admin.email, 'password')
    assert_difference('User.count', 1) do
      click_link "Users"
      click_link "New User"
      fill_in "Email", with: "new@user.tk"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create User"
      assert page.has_content?("new@user.tk"), "User index page should show the new user"
    end
  end

  test 'admin can delete a user' do
    sign_in(@admin.email, 'password')
    assert_difference('User.count', -1) do
      visit admin_users_path
      within(:xpath, %Q{//td[text()="#{@user.email}"]/parent::tr}) do
        click_link "Delete"
      end
    end

    assert_false page.has_content?(@user.email)
  end

  test 'admin can promote a user to admin' do
    sign_in(@admin.email, 'password')
    visit admin_users_path
    within(:xpath, %Q{//td[text()="#{@user.email}"]/parent::tr}) do
      check 'admin'
      sleep 0.1
    end
    
    @user.reload
    assert @user.admin?, "User should have been promoted to admin"
  end

  test "user can't see the users interface" do
    sign_in(@user.email, 'password')
    assert_false page.has_content?("Users"), "non-admin user should not see the User link on the dashboard menu"
    visit admin_users_path
    #assert false
  end

  test 'user can change password' do
    sign_in(@user.email, 'password')
    
    click_link @user.email
  end

  test "user can not change another user's password" do
    sign_in(@admin.email, 'password')

  end
end
