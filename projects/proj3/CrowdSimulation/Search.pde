ArrayList<Vector> astarSearch(HashMap<Vector, HashSet<Vector>> graph, Vector startPos) {
  ArrayList<Vector> path = new ArrayList();
  
  // TODO: Implement
  
  return path;
}

class PathComparator implements Comparator<ArrayList<Vector>>{ 
  // Overriding compare()method of Comparator  
  // for descending order of cgpa 
  public int compare(ArrayList<Vector> p1, ArrayList<Vector> p2) {
    // This is the heuristic... (distance to the goal)
    // The g(x) is the distance to the goal (sum of the paths)
    Vector pos1 = p1.get(p1.size() - 1);
    Vector pos2 = p2.get(p2.size() - 1);
    float d1 = pos1.distance(goalPos);
    float d2 = pos2.distance(goalPos);
    if (d1 > d2) return 1; 
    else if (d1 < d2) return -1;   
    else return 0; 
  } 
        
} 

ArrayList<Vector> uniformCostSearch(HashMap<Vector, HashSet<Vector>> graph, Vector startPos) {
  PriorityQueue<ArrayList<Vector>> queue = new PriorityQueue(11, new PathComparator());
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
