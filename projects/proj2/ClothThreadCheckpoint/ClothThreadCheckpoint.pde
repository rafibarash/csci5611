/*********************************
 * Globals
 ********************************/

// Simulation Parameters
int CLOTH_WIDTH = 10;

// Global Variables
String projectTitle;
Physics physics;
Camera camera;
float lastTime;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(800, 800, P3D);
  projectTitle = "Cloth Checkpoint";
  camera = new Camera();
  physics = new Physics();
  lastTime = millis();
}

void draw() {
  // Update
  for (int i=0; i<150; i++) {
    physics.update((millis() - lastTime)/170000);
  }
  lastTime = millis();
  
  // Render
  background(255);
  physics.render();
  
  // Update camera
  camera.Update( 1.0/frameRate );
  
  // Set display title with runtime report
  String runtimeReport = 
        "FPS: " + str(round(frameRate)) +
        ", Cloth Dimensions: " + CLOTH_WIDTH + "x" + CLOTH_WIDTH + "\n";
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
  
}
