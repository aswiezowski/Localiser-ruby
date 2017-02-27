require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  test "should return valid distance between two locations" do
     loc1 = Location.new(latitude: 52.241929, longitude: 20.993809)
     loc2 = Location.new(latitude: 52.244274, longitude: 21.000941)
     distance = loc1.distance(loc2);
        
     assert_in_delta(551.28, distance, 1)
  end
  
end
