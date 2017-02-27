class TravelingSalesmanSolver

  def findShortestPath(startLocation, initialLocations)
    if initialLocations.size < 4
      return initialLocations
    end
    initDistances(initialLocations)
    solution=[]
    solution << 0
    bestPath = getInitialSolution
    bestDistance = getDistanceWithCycle(bestPath)
    queue = Array.new
    queue << solution
    while (!queue.empty?) do
      solution = getBest(queue)
      queue.delete(solution)
      if (getLowerBound(solution) < bestDistance)
        children = getBranches(solution)
        children.each do |child|
          if child.size == @locations.size
            distanceWithCycle = getDistanceWithCycle(child)
            if distanceWithCycle < bestDistance
              bestDistance = distanceWithCycle
              bestPath = child
            end
          else
            bound = getLowerBound(child)
            if (bound < bestDistance)
              queue<<child
            end
          end

        end
      end
    end
    getResults(startLocation, bestPath)
  end

  def getResults(startLocation, solution)
    startLocationId = @locations.index(startLocation)
    startNode = solution.index(startLocationId)
    resultIndexes = (startNode...solution.size).to_a + (0...startNode).to_a
    resultIndexes.map{|nodeId| @locations[solution[nodeId]]}
  end

  def getBranches(solution)
    branches = Array.new
    (0...@locations.size).each do |node|
      if !solution.include?(node)
        branch = solution.compact
        branch << node
        if branch.size == (@locations.size - 1)
          branch += getMissingNodes(branch)
        end
        branches << branch
      end
    end
    branches
  end

  def getMissingNodes(branch)
    (0...@locations.size).to_a - branch
  end


  def getBest(queue)
    queue.min { |path1, path2| getDistanceWithCycle(path1) <=> getDistanceWithCycle(path2) }
  end

  def getInitialSolution
    Array(0...@locations.size)
  end

  def initDistances(initLocations)
    @distances = Array.new(initLocations.size) { Array.new(initLocations.size, 0) }
    @locations = initLocations
    (0...@locations.size).each do |i|
      (0...@locations.size).each do |j|
        if i == j
          @distances[i][j] = Float::MAX
        else
          @distances[i][j] = @locations[i].distance(@locations[j])
        end

      end
    end
  end

  def getDistanceWithCycle(path)
    distance = 0.0
    (0...path.size-1).each do |i|
      distance += getDistance(path[i], path[i+1])
    end
    distance + getDistance(path.last, path[0])
  end

  def getDistance(from, to)
    @distances[from][to]
  end

  def getLowerBound(partialSolution)
    minDistance = getPathDistance(partialSolution)
    (0...@distances.size).each do |nodeFrom|
      if partialSolution.include?(nodeFrom) || nodeFrom == partialSolution.last
        min = Float::MAX
        (0...@distances.size).each do |nodeTo|
          if !partialSolution.include?(nodeTo)
            min = [min, getDistance(nodeFrom, nodeTo)].min
          end
        end
        minDistance+=min
      end
    end
    minDistance
  end

  def getPathDistance(path)
    distance = 0.0
    (0...path.size-1).each do |i|
      distance += getDistance(path[i], path[i+1])
    end
    distance
  end

end