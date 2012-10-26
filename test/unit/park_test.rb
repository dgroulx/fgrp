require 'test_helper'

class ParkTest < ActiveSupport::TestCase
  setup do
    @park = parks(:aberdeen)
  end

  test 'park must have a name' do
    new_park_attributes = clean_attributes(@park)
    new_park_attributes["name"] = ""
    new_park = Park.new(new_park_attributes)
    assert_false new_park.valid?, "Nameless park should not be valid"
  end
 
  test 'park names are unique' do
    new_park = Park.new(clean_attributes(@park))
    assert_false new_park.valid?, "Park names must be unique"
  end

  test 'parks should generate urls based on their name' do
    # Test slug generation method since fixtures don't trigger callbacks
    assert_equal "aberdeen-park", @park.to_param, "Park#to_param should generate nice slugs for URLs"
  end
end
