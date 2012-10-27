require 'test_helper'

class AdminDashboardTest < ActionDispatch::IntegrationTest
  fixtures :parks, :amenities, :users

  def setup
    sign_in(users(:admin))
  end

  test "admin can reach parks from the dashboard" do
    visit admin_root_path
    click_link "Manage Parks"
    Park.all.map(&:name).each do |park_name|
      assert page.has_content?(park_name)
    end

    click_link "Dashboard"
    assert page.has_content?("Dashboard")
  end

  test "admin can reash amenities from the dashboard" do
    visit admin_root_path
    click_link "Manage Amenities"
    Amenity.all.map(&:name).each do |amenity_name|
      assert page.has_content?(amenity_name)
    end

    click_link "Dashboard"
    assert page.has_content?("Dashboard")
  end
end
