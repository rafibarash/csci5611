/*
CSCI 5611 TODO

- Fix PRM nodes to use “n” nearest neighbors when building graph, check for graph connecting start to goal
- Add path smoothing to graph building
- Add breadth first search, fix agent motion to move along graph
- Update to UCS, then A* search (document gain if A* search)
- Implement local interaction technique for multiple agents
- Allow user to choose agent starts and goals at runtime
- Allow user to add obstacles at runtime
- Implement spatial data structure for PRM construction, use piazza if necessary
- If I somehow get this far, render a 2D or 3D doom game level
*/

import java.util.*;

/*********************************
 * Globals
 ********************************/

// Global Variables
String projectTitle;
FixedModelCamera modelCamera;
Physics physics;
float startTime, updateTime, renderTime;
ArrayList<String> gameModes;
int gameModeIndex;

// Global Simulation Parameters
Vector goalPos;
Vector worldDim;
int numCollisions;

// Global Objects
ArrayList<Agent> agents;
ArrayList<Obstacle> obstacles;
float obstacleRad;

// Models
PShape car;
PShape tree;
PShape goal;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(600, 600, P3D);
  
  // Global Vars
  projectTitle = "Search Checkpoint";
  modelCamera = new FixedModelCamera();
  physics = new Physics();
  gameModes = new ArrayList(Arrays.asList("addObstacles", "addGoal", "addAgents", "runSimulation"));
  gameModeIndex = 0;
  
  // Simulation Parameters
  worldDim = new Vector(width, height);
  numCollisions = 0;
  
  // Obstacles
  obstacles = new ArrayList();
  obstacleRad = 45;
  
  // Add tree obstacles around world
  addWorldBarrier();
  
  // Agents
  agents = new ArrayList();
  
  // Models
  car = loadShape("SportsCar.obj");
  tree = loadShape("BirchTree_Autumn_1.obj");
  //goal = loadShape("Flag.obj");
  goal = loadShape("EgyptianTemple.obj");
  
  // Initialize physics
  physics.init();
}

void draw() {
  
  /*********************************
   * Update
   ********************************/
  startTime = millis();
  // Case to run simulation
  if (gameModes.get(gameModeIndex) == "runSimulation") {
    // Update state
    
    for (int i=0; i<25; i++) {
      //physics.update((millis() - lastTime)/1000);
      physics.update(0.01);
    }
  }
  updateTime = millis();
  
  /*********************************
   * Render
   ********************************/
  
  // Render game dimensions
  renderDefaultScene();
    
  // Case to add obstacles
  for (Obstacle o : obstacles) {
    o.render();
  }
  if (gameModes.get(gameModeIndex) == "addObstacles") {
    fill(0);
    textSize(30);
    text("Click to add obstacles", 85, 30); 
  }
  
  // Case to render goal
  if (goalPos != null) {
    // Render goal position
    // If agent, rotate goal towards agent
    float agentRotY = 0;
    if (agents.size() >= 1) {
      Agent a = agents.get(0);
      agentRotY = a.getGoalRotY();
    }
    float scale = 8;
    pushMatrix();
    translate(goalPos.x, goalPos.y, goalPos.z);
    scale(scale);
    rotateX(radians(90));
    rotateY(radians(agentRotY));
    shape(goal);
    popMatrix();
  }
  if (gameModes.get(gameModeIndex) == "addGoal") {
    fill(0);
    textSize(30);
    text("Click to add a goal position", 85, 30); 
  }
  
  // Case to add agent start positions
  for (Agent a : agents) {
    a.render();
  }
  if (gameModes.get(gameModeIndex) == "addAgents") {
    fill(0);
    textSize(30);
    text("Click to add agents", 85, 30); 
  }
  
  renderTime = millis();
  
  // Update camera
  modelCamera.Update( 1.0/frameRate );

  // Set display title with runtime report
  String runtimeReport = 
        "FPS: " + str(round(frameRate)) +
        ", Update: " + str(updateTime - startTime) + "ms" + 
        ", Render: " + str(renderTime - updateTime) + "ms" +
        ", Collisions: " + str(numCollisions);
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
}

void keyPressed()
{
  modelCamera.HandleKeyPressed();
  
  // Handle game mode presses
  if (keyPressed && keyCode == 10 && gameModes.get(gameModeIndex) != "runSimulation") {
    ++gameModeIndex;
    // Construct roadmap if it is time
    if (gameModes.get(gameModeIndex) == "runSimulation") {
      modelCamera.setAgent(agents.get(0));
      physics.constructPRMRoadmap();
    }
  }
}

void keyReleased()
{
  modelCamera.HandleKeyReleased();
}

void mousePressed() {
  // Handle obstacles mode
  //if (gameModes.get(gameModeIndex) == "addObstacles") {
  //  obstacles.add(new Obstacle(new Vector(mouseX, mouseY), obstacleRad));
  //}
  
  // Handle goal mode
  if (gameModes.get(gameModeIndex) == "addGoal") {
    goalPos = new Vector(mouseX, mouseY);
    gameModeIndex++;
  }
  
  // Handle agents mode
  else if (gameModes.get(gameModeIndex) == "addAgents") {
    agents.add(new Agent(new Vector(mouseX, mouseY), goalPos));
  }
}

int separator = 0;

void mouseDragged() {
  // Handle obstacles mode
  if (gameModes.get(gameModeIndex) == "addObstacles" && separator == 4) {
    obstacles.add(new Obstacle(new Vector(mouseX, mouseY), obstacleRad));
    separator = 0;
  } else {
    separator++;
  }
}



// HELPERS
void renderDefaultScene() {
  // Render default stuff
  background(255);
  lights();
  
  // Floor
  fill(34,139,34);  // forest green
  pushMatrix();
  translate(width/2-10, height/2-10, 0); 
  box(width+25, height+25, 2);
  popMatrix();
  
  // For future...
  noFill();
  stroke(0);
  
  // barrier used for now
  //rect(0, 0, worldDim.x, worldDim.y);
}

void addWorldBarrier() {
  // Add trees around world
  float k = 10;  // cushioning around border
  for (int i=0; i<width; i+= obstacleRad/5) {
    obstacles.add(new Obstacle(new Vector(i, -k), obstacleRad));        // Top
    obstacles.add(new Obstacle(new Vector(width+k, i), obstacleRad));   // Right
    obstacles.add(new Obstacle(new Vector(i, height+k), obstacleRad));  // Bottom
    obstacles.add(new Obstacle(new Vector(-k, i), obstacleRad));        // Left
  }
}
