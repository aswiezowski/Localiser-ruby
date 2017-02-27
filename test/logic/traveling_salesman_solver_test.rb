require 'test_helper'

class TravelingSalesmanSolverTest  < ActiveSupport::TestCase

  def test_ShouldReturnSamePathWhenLessThanFourLocations
    solver = TravelingSalesmanSolver.new
    loc1 = Location.new(latitude: 52.249592, longitude: 21.012296, description: 'Main Square')
    loc2 = Location.new(latitude: 52.247608, longitude: 21.014779, description: "King's Castle")
    loc3 = Location.new(latitude: 52.242998, longitude: 21.016722, description: 'Presidential Palace')
    initialLocations = [loc1, loc2, loc3]

    path = solver.findShortestPath(loc3, initialLocations)

    assert_equal(initialLocations, path)
  end

  def test_ShouldReturnLessOrEqualPathDistance
      solver = TravelingSalesmanSolver.new
      distanceCalculator = DistanceCalculator.new
      loc1 = Location.new(latitude: 50.061424, longitude: 19.937340, description: 'Main Square')
      loc2 = Location.new(latitude: 50.054877, longitude: 19.893238, description: 'Koscioszko Mound')
      loc3 = Location.new(latitude: 50.054877, longitude: 19.893238, description: 'Pilsudzki Mound')
      loc4 = Location.new(latitude: 50.037975, longitude: 19.958465, description: 'Krak Mound')
      loc5 = Location.new(latitude: 50.054877, longitude: 19.893238, description: 'Wanda Mound')
      initialLocations = [loc1, loc2, loc3, loc4, loc5]

      path = solver.findShortestPath(loc3, initialLocations)
      pathDistance = distanceCalculator.getDistanceWithCycle(path)
      initialPathDistance = distanceCalculator.getDistanceWithCycle(initialLocations)

      assert(pathDistance <= initialPathDistance)
  end

  def test_shouldReturnEqualDistanceWhenPermutatingLocations
    solver = TravelingSalesmanSolver.new
    distanceCalculator = DistanceCalculator.new
    loc1 = Location.new(latitude: 50.070892, longitude: 19.938521, description: "krakow");
    loc2 = Location.new(latitude: 50.254658, longitude: 19.024302, description: "katowice");
    loc3 = Location.new(latitude: 51.755600, longitude: 19.450057, description: "lodz");
    loc4 = Location.new(latitude: 52.399548, longitude: 16.920722, description: "poznan");
    loc5 = Location.new(latitude: 52.220967, longitude: 21.015730, description: "warszawa");

    path = solver.findShortestPath(loc3, [loc1, loc2, loc3, loc4, loc5])
    path2 = solver.findShortestPath(loc1, [loc5, loc2, loc1, loc4, loc3])
    path1Distance = distanceCalculator.getDistanceWithCycle(path)
    path2Distance = distanceCalculator.getDistanceWithCycle(path2)

    assert_in_delta(path1Distance, path2Distance, 0.0001);
  end

end