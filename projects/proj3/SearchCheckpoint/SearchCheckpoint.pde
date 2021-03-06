/*
CSCI 5611 TODO

- Fix line collision detection algorithm
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

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(600, 600, P3D);
  
  // Global Vars
  projectTitle = "Search Checkpoint";
  camera = new Camera();
  physics = new Physics();
  
  // Initialize physics
  physics.init();
}

void draw() {
  // Update state
  startTime = millis();
  for (int i=0; i<12; i++) {
    //physics.update((millis() - lastTime)/1000);
    physics.update(0.02);
  }
  updateTime = millis();
  
  // Render state
  lights();
  background(255);
  physics.render();
  renderTime = millis();
  
  // Update camera
  camera.Update( 1.0/frameRate );
  
  // Set display title with runtime report
  String runtimeReport = 
        "FPS: " + str(round(frameRate)) +
        ", Update: " + str(updateTime - startTime) + "ms" + 
        ", Render: " + str(renderTime - updateTime) + "ms" +
        ", Position: " + physics.agent.getPosition() + "\n";
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
  
}
