require 'test_helper'

class AdminCanManageParks < ActionDispatch::IntegrationTest
  fixtures :parks

  ParkMock = Struct.new(:name, :history, :latitude, :longitude, :contact_info, 
                        :park_size, :address, :vimeo_embed, :flicker_pool, :section)
  @@new_park = ParkMock.new
  @@new_park.name = "Baldwin Park"
  
  test "admin can create a park" do
    assert_difference('Park.count', 1) do
      visit admin_parks_path
      click_link "New Park"
      fill_in :name, with: @@new_park[:name]
      click_button "Create Park"
      assert page.has_content?(@@new_park.name), "Admin::Parks#index should show park names"
    end
  end

  test "admin can update a park" do
    @park = Park.first
    visit admin_parks_path
    click_link @park.name
    assert_equal @park.name, page.find("#park_name").value    
    fill_in :name, with: "New Park Name"
    click_button "Update Park"
    assert page.has_content?("New Park Name"), "Admin::Parks#update should update parks"   
  end

  test "admin can delete a park" do
    @park = parks(:aberdeen)
    visit admin_parks_path
    assert_difference('Park.count', -1) do
      within(:xpath, %Q{//td[a[text()="#{@park.name}"]]/parent::tr}) do
        click_link "Delete"
      end  
    end

    assert_false page.has_content?(@park.name)
  end
end
