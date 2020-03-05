class Physics {
  // Simulation Parameters
  Vector initPos;
  Vector goalPos;
  Vector obstaclePos;
  float obstacleRad;
  Vector worldDim;
  float gridSize;
  ArrayList<Vector> pastAgentPositions;
  
  // Objects
  Agent agent;
  
  Physics() {
    // Simulation Parameters
    worldDim = new Vector(100, 100);
    gridSize = 5;
    goalPos = new Vector(worldDim.x-gridSize, gridSize);
    initPos = new Vector(gridSize, worldDim.y-gridSize);
    obstacleRad = 2;
    obstaclePos = new Vector(50, 50);
    pastAgentPositions = new ArrayList();
    
    // Objects
    agent = new Agent(initPos.copy());
  }
  
  
  void update(float dt){
    // Update character position
    agent.goalPos = goalPos;
    agent.update(dt);
  }
  
  void render() {
    // Render Start Position, Goal Position, Past Character Movement
    renderContext();
    
    // Render Character
    agent.render();
    
    // TODO: Render Obstacles
    
    
    //// Floor
    //fill(0, 255, 0);
    //pushMatrix();
    //translate(0, 402, 0); 
    //box(800, 2, 800);
    //popMatrix();
    
    //// Sphere
    //fill(153, 51, 255);
    //noStroke();
    //pushMatrix();
    //translate(spherePos.x, spherePos.y, spherePos.z);
    //sphere(sphereRadius);
    //popMatrix();
    
    //// Cloth
    //cloth.render();
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
    }
  }
}
