require 'test_helper'

class VisitorCanBrowseParksTest < ActionDispatch::IntegrationTest
  fixtures :parks

  test 'Visitor can see all parks on the index page' do
    visit parks_path
    Park.all.each do |park|
      assert page.has_content?(park.name), "Park name #{park.name} is not visible on Park#index"
    end 
  end

  test "Visitor can reach a park's page from the index page" do
    visit parks_path
    target_park = Park.first
    click_link target_park.name
    assert page.has_content?(target_park.history)
  end

  test "Visitor can see amenities on the park's page" do

  end
end
