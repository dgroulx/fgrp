require 'test_helper'

class AdminCanManageAmenitiesTest < ActionDispatch::IntegrationTest
  fixtures :amenities

  test "admin can create a amenity" do
    assert_difference('Amenity.count', 1) do
      visit admin_amenities_path
      click_link "New Amenity"
      fill_in :name, with: "Soccer Fields"
      click_button "Create Amenity"
      assert page.has_content?("Soccer Fields"), "Admin::Amenities#index should show amenity names"
    end
  end

  test "admin can update an amenity" do
    @amenity = Amenity.first
    visit admin_amenities_path
    click_link @amenity.name
    assert_equal @amenity.name, page.find("#amenity_name").value
    fill_in :name, with: "New Amenity Name"
    click_button "Update Amenity"
    assert page.has_content?("New Amenity Name"), "Admin::Amenities#update should update amenity"
  end

  test "admin can delete an amenity" do
    @amenity = amenities(:playground)
    visit admin_amenities_path
    assert_difference('Amenity.count', -1) do
      within(:xpath, %Q{//td[a[text()="#{@amenity.name}"]]/parent::tr}) do
        click_link "Delete"
      end
    end

    assert_false page.has_content?(@amenity.name)
  end
end
