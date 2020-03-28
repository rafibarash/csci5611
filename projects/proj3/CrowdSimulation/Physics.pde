class Physics {
  // Simulation Parameters
  HashMap<Vector, HashSet<Vector>> roadmap;
  
  // Inialize Physics
  void init() {
    // Simulation Parameters
    
    // Construct Roadmap
    //constructPRMRoadmap();
  }
  
  void update(float dt){
    // Keep agent pos to visualize
    for (Agent agent : agents) {
      agent.update(dt);
    }
  }
  
  // PRM Roadmap
  void constructPRMRoadmap() {
    int numSamples = 40;
    int maxDistance = 50;
    ArrayList<Vector> nodes = new ArrayList();     // all sampled nodes
    ArrayList<ArrayList<Vector>> paths;            // all paths from start to finish
    HashMap<Vector, HashSet<Vector>> graph;        // graph connecting nodes with k neighbors
    // Add goal and init positions
    nodes.add(goalPos);
    for (Agent a : agents) {
      nodes.add(a.initPos);
    }
    // Continuously sample nodes until valid graph connecting start and end is built 
    int numTries = 0;
    while(true) {
      // Sample nodes and build graph
      ArrayList<Vector> sampledNodes = sampleValidNodes(numSamples*numTries);
      nodes.addAll(sampledNodes);
      graph = buildGraph(nodes, maxDistance);
      // Search for all paths from agent start to goal
      boolean allValidPaths = true;
      paths = new ArrayList();
      ArrayList<Vector> path;
      for (Agent a : agents) {
        Vector initPos = a.initPos;
        //path = breadthFirstSearch(graph, initPos);
        path = uniformCostSearch(graph, initPos);
        if (path != null) {
          paths.add(path);
        } else {
          allValidPaths = false;
          numTries++;
          break;
        }
      }
      if (allValidPaths) break;
      if (numTries == 15) {
        println("After 15 tries, no graph connecting agent starts to goal position found");
      }
    }
    // Set roadmap and agent path
    roadmap = graph;
    int i=0;
    for (Agent agent : agents) {
      ArrayList<Vector> path = paths.get(i++);
      agent.setPath(path);
    }
  }
  
  // Helper method for constructRoadmap to sample 'n' nodes and return a list of valid nodes
  private ArrayList<Vector> sampleValidNodes(int n) {
    float x, y;        // Random coordinates
    Vector sampledPos; // Randomly sampled position
    ArrayList<Vector> validNodes = new ArrayList();  // keep track of valid nodes
    // Loop through n samples, add collision free positions to 'validNodes' list
    for (int i=0; i < n; i++) {
      x = random(worldDim.x);
      y = random(worldDim.y);
      sampledPos = new Vector(x, y);
      if (isCollisionFree(sampledPos)) {
        validNodes.add(sampledPos);
      }
    }
    return validNodes;
  }
  
  // Helper method for constructRoadmap to build graph out of valid nodes
  private HashMap<Vector, HashSet<Vector>> buildGraph(ArrayList<Vector> nodes, int maxDistance) {
    HashMap<Vector, HashSet<Vector>> graph = new HashMap();
    // loop through nodes and create graph
    for (Vector n : nodes) {
      HashSet<Vector> edges = new HashSet();
      for (Vector otherNode : nodes) {
        boolean validDistance = n.distance(otherNode) < maxDistance;
        if (otherNode != n && collisionFreePath(n, otherNode)) {
          edges.add(otherNode);
        }
      }
      graph.put(n, edges);
    }
    return graph;
  }
  
  // Helper method for localPathPlanner to interpolate for collision free path
  private boolean collisionFreePath(Vector n1, Vector n2) {
    for (Obstacle o : obstacles) {
      if (o.isCollision(n1, n2)) return false;
    }
    return true;
  }
  
  
  
  // Helper method for constructRoadmap to check if position collides with an obstacle
  private boolean isCollisionFree(Vector pos) {
    for (Obstacle o : obstacles) {
      if (o.isCollision(pos)) return false;
    }
    return true;
  }
  
  // Helper method for renderContext() to render PRM graph
  void renderRoadmap() {
    stroke(50);
    for (Map.Entry<Vector,HashSet<Vector>> entry : roadmap.entrySet()) {
      Vector node = entry.getKey();
      // Render vertex
      fill(50);
      circle(node.x, node.y, 2);
      // Render Edges
      HashSet<Vector> edges = entry.getValue();
      for (Vector otherNode : edges) {
        stroke(200);
        line(node.x, node.y, otherNode.x, otherNode.y);
      }
    }
  }
}
