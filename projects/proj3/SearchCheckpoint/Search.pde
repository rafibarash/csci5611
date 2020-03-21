ArrayList<Vector> astarSearch(HashMap<Vector, HashSet<Vector>> graph) {
  ArrayList<Vector> path = new ArrayList();
  
  // TODO: Implement
  
  return path;
}

ArrayList<Vector> uniformCostSearch(HashMap<Vector, HashSet<Vector>> graph) {
  ArrayList<Vector> path = new ArrayList();
  
  // TODO: Implement
  
  return path;
}

ArrayList<Vector> breadthFirstSearch(HashMap<Vector, HashSet<Vector>> graph, Vector startPos, Vector goalPos) {
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
