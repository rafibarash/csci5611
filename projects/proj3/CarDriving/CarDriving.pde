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
//Camera camera;
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
  //camera = new Camera();
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
  // Make sure agents drawn after lines
  //hint(DISABLE_OPTIMIZED_STROKE);
  
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
  
  // Render state
  background(255);
  lights();
  
  // Render game dimensions
  noFill();
  stroke(0);
  rect(0, 0, worldDim.x, worldDim.y);
  
  // Render agent paths if possible
  //if (physics.roadmap != null) {
  //  for (Agent a : agents) {
  //    a.renderLineToNextNode();
  //  }
  //}
    
  // Case to add obstacles
  for (Obstacle o : obstacles) {
    o.render();
  }
  if (gameModes.get(gameModeIndex) == "addObstacles") {
    fill(0);
    textSize(30);
    text("Click to add obstacles", 85, 30); 
  }
  
  // Case to add goal
  if (goalPos != null) {
    // Render goal position
    //fill(0, 0, 255);
    //noStroke();
    //circle(goalPos.x, goalPos.y, obstacleRad);
    float scale = 8;
    pushMatrix();
    translate(goalPos.x, goalPos.y, goalPos.z);
    scale(scale);
    rotateX(radians(90));
    rotateY(radians(90));
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
  //if (modelCamera != null) {
  //  modelCamera.Update(1.0/frameRate);
  //} else {
  //  camera.Update( 1.0/frameRate );
  //}
  
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
