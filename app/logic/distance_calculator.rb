class DistanceCalculator


  def getDistanceWithCycle(locations)
    if locations.empty?
      return 0;
    end
    distance = getDistance locations
    distance + locations[0].distance(locations.last)
  end

  def getDistance(locations)
    distance = 0.0
    (0...locations.size-1).each { |i|
      distance += locations[i].distance(locations[i + 1])
    }
    distance;
  end

end