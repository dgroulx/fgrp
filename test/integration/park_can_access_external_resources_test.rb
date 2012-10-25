require 'test_helper'

class ParkCanAccessExternalResourcesTest < ActionDispatch::IntegrationTest
  fixtures :parks

  def setup
    @park = Park.first
  end

  test "google maps is visible on the park's show page" do
    Capybara.current_driver = Capybara.javascript_driver
    visit park_path(@park)
    # Google Maps API inserts a new div into the map_canvas div,
    # we assume if that exists then everything is okay.
    assert page.has_css?("div#map_canvas div"), "Could not load Google Maps"
  end
end
