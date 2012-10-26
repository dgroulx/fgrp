require 'test_helper'

class ParkTest < ActiveSupport::TestCase
  setup do
    @park = parks(:aberdeen)
  end

  test 'park must have a name' do
    new_park_attributes = clean_attributes(@park)
    new_park_attributes[:name] = ""
    Park.new(new_park_attributes)
    assert_false Park.valid?, "Nameless park should not be valid"
  end
 
  test 'park names are unique' do
    Park.new(@park.to_has)
    assert_false Park.valid?, "Park names must be unique"
  end
end
