ArrayList<Vector> astarSearch(HashMap<Vector, HashSet<Vector>> graph, Vector startPos) {
  PriorityQueue<ArrayList<Vector>> queue = new PriorityQueue(11, new AstarPathComparator());
  HashSet<Vector> visited = new HashSet();
  queue.add(new ArrayList(Arrays.asList(startPos)));
  while (!queue.isEmpty()) {
    // Get current path and last node in path from queue
    ArrayList<Vector> curPath = queue.poll();
    Vector curNode = curPath.get(curPath.size() - 1);
    // Add all neighbors of curNode to queue who have not yet been visited
    HashSet<Vector> neighbors = graph.get(curNode);
    for (Vector node : neighbors) {
      // Only process if not visited
      if (!visited.contains(node)) {
        // Check for goalPos
        if (node == goalPos) {
          curPath.add(node);
          return curPath;
        }
        // Create new path with node and add to queue. Add node to visited
        ArrayList<Vector> nextPath = (ArrayList<Vector>) curPath.clone();
        nextPath.add(node);
        queue.add(nextPath);
        visited.add(node);
      }
    }
  }
  // No path found...
  return null;
}

class AstarPathComparator implements Comparator<ArrayList<Vector>>{ 
  public int compare(ArrayList<Vector> path1, ArrayList<Vector> path2) {
    // Calculate g(x), the sum distance of positions in path
    float sum1 = sumPathDistance(path1);
    float sum2 = sumPathDistance(path2);
    
    // Calculate h(x), the distance to goal
    Vector pos1 = path1.get(path1.size() - 1);
    Vector pos2 = path2.get(path2.size() - 1);
    float d1 = pos1.distance(goalPos);
    float d2 = pos2.distance(goalPos);
    
    float f1 = sum1 + d1;
    float f2 = sum2 + d2;
    if (f1 > f2) return 1; 
    else if (f1 < f2) return -1;   
    else return 0; 
  }    
} 

// Thank you Professor Guy for helping me understand this! Also leaving the wikipedia link here
// https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
ArrayList<Vector> uniformCostSearch(HashMap<Vector, HashSet<Vector>> graph, Vector startPos) {
  PriorityQueue<ArrayList<Vector>> queue = new PriorityQueue(11, new UcsPathComparator());
  HashSet<Vector> visited = new HashSet();
  queue.add(new ArrayList(Arrays.asList(startPos)));
  while (!queue.isEmpty()) {
    // Get current path and last node in path from queue
    ArrayList<Vector> curPath = queue.poll();
    Vector curNode = curPath.get(curPath.size() - 1);
    // Add all neighbors of curNode to queue who have not yet been visited
    HashSet<Vector> neighbors = graph.get(curNode);
    for (Vector node : neighbors) {
      // Only process if not visited
      if (!visited.contains(node)) {
        // Check for goalPos
        if (node == goalPos) {
          curPath.add(node);
          return curPath;
        }
        // Create new path with node and add to queue. Add node to visited
        ArrayList<Vector> nextPath = (ArrayList<Vector>) curPath.clone();
        nextPath.add(node);
        queue.add(nextPath);
        visited.add(node);
      }
    }
  }
  // No path found...
  return null;
}

class UcsPathComparator implements Comparator<ArrayList<Vector>>{ 
  public int compare(ArrayList<Vector> path1, ArrayList<Vector> path2) {
    // Calculate g(x), the sum distance of positions in path
    float sum1 = sumPathDistance(path1);
    float sum2 = sumPathDistance(path2);
    if (sum1 > sum2) return 1;
    else if (sum1 < sum2) return -1;
    else return 0;
  }    
} 

ArrayList<Vector> breadthFirstSearch(HashMap<Vector, HashSet<Vector>> graph, Vector startPos) {
  Queue<ArrayList<Vector>> queue = new ArrayDeque();
  HashSet<Vector> visited = new HashSet();
  queue.add(new ArrayList(Arrays.asList(startPos)));
  while (!queue.isEmpty()) {
    // Get current path and last node in path from queue
    ArrayList<Vector> curPath = queue.poll();
    Vector curNode = curPath.get(curPath.size() - 1);
    // Add all neighbors of curNode to queue who have not yet been visited
    HashSet<Vector> neighbors = graph.get(curNode);
    for (Vector node : neighbors) {
      // Only process if not visited
      if (!visited.contains(node)) {
        // Check for goalPos
        if (node == goalPos) {
          curPath.add(node);
          return curPath;
        }
        // Create new path with node and add to queue. Add node to visited
        ArrayList<Vector> nextPath = (ArrayList<Vector>) curPath.clone();
        nextPath.add(node);
        queue.add(nextPath);
        visited.add(node);
      }
    }
  }
  // No path found...
  return null;
}

/***********************************
 * Helper Functions
 **********************************/
 
// Calculates sum distance of positions in path, g(x)
float sumPathDistance(ArrayList<Vector> path) {
  float sum = 0;
  Vector prev = path.get(0);
  for (int i=1; i < path.size(); i++) {
    Vector cur = path.get(i);
    sum += prev.distance(cur);
    prev = cur;
  }
  return sum;
}
