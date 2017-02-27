require 'test_helper'

class DistanceCalculatorTest  < ActiveSupport::TestCase

  def test_shouldReturnValidDistanceForTwoLocations
    distanceCalculator = DistanceCalculator.new
    loc1 = Location.new
    loc2 = Location.new
    loc1.expects(:distance).with(loc2).returns(10.0)

    distance = distanceCalculator.getDistance([loc1, loc2]);

    assert_in_delta(10.0, distance, 0.00001);
  end

  def test_shouldReturnValidDistanceWithCycleForTwoLocations
    distanceCalculator = DistanceCalculator.new
    loc1 = Location.new
    loc2 = Location.new
    loc1.expects(:distance).at_least_once.with(loc2).returns(10.0)
    loc2.expects(:distance).at_most_once.with(loc1).returns(10.0)

    distance = distanceCalculator.getDistanceWithCycle([loc1, loc2]);

    assert_in_delta(20.0, distance, 0.00001);
  end

  def test_shouldReturnZeroWhenDistanceWithCycleForNoLocation
    distanceCalculator = DistanceCalculator.new

    distance = distanceCalculator.getDistanceWithCycle([])

    assert_in_delta(0.0, distance, 0.00001);
  end

end