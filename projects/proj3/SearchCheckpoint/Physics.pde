class Physics {
  // Simulation Parameters
  Vector initPos;
  Vector goalPos;
  Vector obstaclePos;
  float obstacleRad;
  Vector worldDim;
  float gridSize;
  ArrayList<Vector> pastAgentPositions;
  ArrayList<Obstacle> obstacles;
  HashMap<Vector, HashSet<Vector>> roadmap;
  
  // Objects
  Agent agent;
  Obstacle circle;
  
  // Inialize Physics
  void init() {
    // Simulation Parameters
    worldDim = new Vector(100, 100);
    gridSize = 5;
    goalPos = new Vector(worldDim.x-gridSize, gridSize);
    initPos = new Vector(gridSize, worldDim.y-gridSize);
    obstaclePos = new Vector(worldDim.x/2, worldDim.y/2);
    obstacleRad = 20;
    pastAgentPositions = new ArrayList();
    obstacles = new ArrayList();
    
    // Obstacles
    circle = new Obstacle(obstaclePos);
    circle.radius = obstacleRad;
    obstacles.add(circle);
    
    // Agents
    agent = new Agent(initPos, goalPos);
    
    // Construct Roadmap
    constructPRMRoadmap();
  }
  
  void update(float dt){
    // Keep agent pos to visualize
    if (!agent.isDead) {
      //agent.goalPos = new Vector(mouseX, mouseY);
      agent.update(dt);
      storeAgentPos();
    }
  }
  
  void render() {
    // Render Character
    agent.render();
    
    // Render Obstacles
    for (Obstacle o : obstacles) {
      o.render();
    }
    
    // Render Start Position, Goal Position, Past Character Movement, Roadmap
    renderContext();
  }
  
  void storeAgentPos() {
    pastAgentPositions.add(agent.pos.copy());
  }
  
  // PRM Roadmap
  void constructPRMRoadmap() {
    int numSamples = 20;
    int numNeighbors = 8;
    ArrayList<Vector> nodes = new ArrayList();     // all sampled nodes
    ArrayList<Vector> path;                        // path from start to finish
    HashMap<Vector, HashSet<Vector>> graph;        // graph connecting nodes with k neighbors
    nodes.add(initPos);
    nodes.add(goalPos);
    // Continuously sample nodes until valid graph connecting start and end is built 
    while(true) {
      // Sample nodes and build graph
      ArrayList<Vector> sampledNodes = sampleValidNodes(numSamples);
      nodes.addAll(sampledNodes);
      graph = buildGraph(nodes, numNeighbors);
      // Search for path from start to goal
      path = breadthFirstSearch(graph, initPos, goalPos);
      if (path != null) break;
    }
    // Set roadmap and agent path
    roadmap = graph;
    agent.setPath(path);
    println(roadmap);
    println(path);
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
  private HashMap<Vector, HashSet<Vector>> buildGraph(ArrayList<Vector> nodes, int kNeighbors) {
    HashMap<Vector, HashSet<Vector>> graph = new HashMap();
    // loop through nodes and create graph
    for (Vector n : nodes) {
      HashSet<Vector> edges = new HashSet();
      for (Vector otherNode : nodes) {
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
  
  Vector getRandomEdgeNode(Vector graphKey) {
    HashSet<Vector> edges = roadmap.get(graphKey);
    if (edges == null) {
      println("Couldn't get edges from graphKey", graphKey);
      exit();
      return null;
    }
    // Generate random index
    int i = (int) random(edges.size());
    // Get node in hashset
    // Doing this inside a loop so chosen node is not initial position if possible
    for (int j=0; j < 5; j++) {
      for (Vector v : edges) {
        if (i-- == 0 && v != initPos) return v;
      }
    }
    println("Couldn't generate random node, likely no node edge");
    return initPos;
  }
  
  // Render Start Position, Goal Position, Past Character Movement
  private void renderContext() {
    // Render game dimensions
    noFill();
    stroke(0);
    rect(0, 0, worldDim.x, worldDim.y);
    
    // Render roadmap
    renderRoadmap();
    
    // Render initial position
    fill(255, 0, 0);
    noStroke();
    circle(initPos.x, initPos.y, 4);
    
    // Render goal position
    fill(0, 0, 255);
    noStroke();
    circle(goalPos.x, goalPos.y, 4);

    // Render past character movement
    for (Vector pos : pastAgentPositions) {
      stroke(0, 255, 0);
      noFill();
      circle(pos.x, pos.y, 0.1);
    }
  }
  
  // Helper method for renderContext() to render PRM graph
  private void renderRoadmap() {
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
