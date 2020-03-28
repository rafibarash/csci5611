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
Camera camera;
Physics physics;
float startTime, updateTime, renderTime;
ArrayList<String> gameModes;
int gameModeIndex;

// Global Simulation Parameters
Vector goalPos;
Vector worldDim;

// Global Objects
ArrayList<Agent> agents;
ArrayList<Obstacle> obstacles;
float obstacleRad;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(600, 600, P3D);
  
  // Global Vars
  projectTitle = "Search Checkpoint";
  camera = new Camera();
  physics = new Physics();
  gameModes = new ArrayList(Arrays.asList("addObstacles", "addGoal", "addAgents", "runSimulation"));
  gameModeIndex = 0;
  
  // Simulation Parameters
  worldDim = new Vector(width, height);
  
  // Obstacles
  obstacles = new ArrayList();
  obstacleRad = 30;
  
  // Agents
  agents = new ArrayList();
  
  // Initialize physics
  physics.init();
}

void draw() {
  startTime = millis();
  // Case to run simulation
  if (gameModes.get(gameModeIndex) == "runSimulation") {
    // Update state
    
    for (int i=0; i<12; i++) {
      //physics.update((millis() - lastTime)/1000);
      physics.update(0.02);
    }
  }
  updateTime = millis();
  
  // Render state
  lights();
  background(255);
  
  // Render game dimensions
  noFill();
  stroke(0);
  rect(0, 0, worldDim.x, worldDim.y);
  
  // Render roadmap if possible
  if (physics.roadmap != null) {
    physics.renderRoadmap();
  }
    
  // Case to add obstacles
  if (gameModeIndex >= 0) {
    // Draw obstacles
    for (Obstacle o : obstacles) {
      o.render();
    }
    if (gameModes.get(gameModeIndex) == "addObstacles") {
      fill(0);
      textSize(30);
      text("Click to add obstacles", 85, 30); 
    }
  }
  
  // Case to add goal
  if (gameModeIndex >= 1) {
    if (goalPos != null) {
      // Render goal position
      fill(0, 0, 255);
      noStroke();
      circle(goalPos.x, goalPos.y, obstacleRad);
    }
    if (gameModes.get(gameModeIndex) == "addGoal") {
      fill(0);
      textSize(30);
      text("Click to add a goal position", 85, 30); 
    }
  }
  
  // Case to add agent start positions
  if (gameModeIndex >= 2) {
    // Draw agents
    for (Agent a : agents) {
      a.render();
    }
    if (gameModes.get(gameModeIndex) == "addAgents") {
      fill(0);
      textSize(30);
      text("Click to add agents", 85, 30); 
    }
  }
  
  renderTime = millis();
  
  // Update camera
  camera.Update( 1.0/frameRate );
  
  // Set display title with runtime report
  String runtimeReport = 
        "FPS: " + str(round(frameRate)) +
        ", Update: " + str(updateTime - startTime) + "ms" + 
        ", Render: " + str(renderTime - updateTime) + "ms";
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
}

void keyPressed()
{
  camera.HandleKeyPressed();
  
  // Handle game mode presses
  if (keyPressed && keyCode == 10 && gameModes.get(gameModeIndex) != "runSimulation") {
    ++gameModeIndex;
    // Construct roadmap if it is time
    if (gameModes.get(gameModeIndex) == "runSimulation") {
      physics.constructPRMRoadmap();
    }
  }
  
  
}

void keyReleased()
{
  camera.HandleKeyReleased();
}

void mousePressed() {
  // Handle obstacles mode
  if (gameModes.get(gameModeIndex) == "addObstacles") {
    obstacles.add(new Obstacle(new Vector(mouseX, mouseY), obstacleRad));
  }
  
  // Handle goal mode
  else if (gameModes.get(gameModeIndex) == "addGoal") {
    goalPos = new Vector(mouseX, mouseY);
    gameModeIndex++;
  }
  
  // Handle agents mode
  else if (gameModes.get(gameModeIndex) == "addAgents") {
    agents.add(new Agent(new Vector(mouseX, mouseY), goalPos));
  }
}
