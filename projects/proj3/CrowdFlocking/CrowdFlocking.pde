import java.util.HashSet;
import java.util.Map;

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
