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
  
  Physics() {
    // Simulation Parameters
    worldDim = new Vector(100, 100);
    gridSize = 5;
    goalPos = new Vector(worldDim.x-gridSize, gridSize);
    initPos = new Vector(gridSize, worldDim.y-gridSize);
    obstaclePos = new Vector(worldDim.x/2, worldDim.y/2);
    obstacleRad = 20;
    pastAgentPositions = new ArrayList();
    obstacles = new ArrayList();
    
    // Objects
    agent = new Agent(initPos.copy());
    circle = new Obstacle(obstaclePos);
    circle.radius = obstacleRad;
    obstacles.add(circle);
  }
  
  
  void update(float dt){
    // Update character position
    agent.goalPos = goalPos;
    //agent.goalPos = new Vector(mouseX, mouseY);
    agent.update(dt);
    // Keep agent pos to visualize
    storeAgentPos();
  }
  
  void render() {
    // Render Character
    agent.render();
    
    // Render Obstacles
    for (Obstacle o : obstacles) {
      o.render();
    }
    
    // Render Start Position, Goal Position, Past Character Movement
    renderContext();
    
    // FOR NOW, render roadmap
    fill(0);
    for (Map.Entry<Vector,HashSet<Vector>> entry : roadmap.entrySet()) {
      Vector node = entry.getKey();
      HashSet<Vector> edges = entry.getValue();
      circle(node.x, node.y, 2);
      for (Vector otherNode : edges) {
        line(node.x, node.y, otherNode.x, otherNode.y);
      }
    }
  }
  
  void storeAgentPos() {
    pastAgentPositions.add(agent.pos.copy());
  }
  
  void constructRoadmap() {
    int n = 10;    // Num Samples 
    ArrayList<Vector> validNodes;
    HashMap<Vector, HashSet<Vector>> constructedGraph;
    validNodes = sampleValidNodes(n);
    constructedGraph = localPathPlanner(validNodes);
    roadmap = constructedGraph;
    print(roadmap);
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
  private HashMap<Vector, HashSet<Vector>> localPathPlanner(ArrayList<Vector> validNodes) {
    HashMap<Vector, HashSet<Vector>> graph = new HashMap();
    // initialize graph
    for (Vector n : validNodes) {
      HashSet<Vector> edges = new HashSet();
      for (Vector otherNode : validNodes) {
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
  
  // Render Start Position, Goal Position, Past Character Movement
  private void renderContext() {
    // Render game dimensions
    noFill();
    stroke(0);
    rect(0, 0, worldDim.x, worldDim.y);
    
    // Render initial position
    fill(255, 0, 0);
    noStroke();
    circle(initPos.x, initPos.y, 3);
    
    // Render goal position
    fill(0, 0, 255);
    circle(goalPos.x, goalPos.y, 3);
    
    // Render past character movement
    for (Vector pos : pastAgentPositions) {
      // TODO: render dash
      stroke(0);
      point(pos.x, pos.y);
    }
  }
}
