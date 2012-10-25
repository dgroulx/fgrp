require 'test_helper'

class AdminCanManageParks < ActionDispatch::IntegrationTest
  fixtures :parks

  test "admin can create a park" do
    assert_difference('Park.count', 1) do
      visit admin_parks_path
      click_link "New Park"
      fill_in :name, with: "Aberdeen Park"
      click_button "Create Park"
      assert page.has_content?("Aberdeen Park"), "Admin::Park#index should show park names"
    end
  end

  test "admin can update a park" do
    @park = parks(:aberdeen)
    visit admin_parks_path
    click_link @park.name
    assert_equal @park.name, page.find("#park_name").value    
    fill_in :name, with: "New Park Name"
    click_button "Update Park"
    assert page.has_content?("New Park Name"), "Admin::Park#update should update parks"   
  end

  test "admin can delete a park" do
    @park = parks(:aberdeen)
    visit admin_parks_path
    within(:xpath, %Q{//td[a[text()="#{@park.name}"]]/parent::tr}) do
      click_link "Delete"
    end  
    assert_false page.has_content?(@park.name)
  end
end
