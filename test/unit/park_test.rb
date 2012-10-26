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
end
