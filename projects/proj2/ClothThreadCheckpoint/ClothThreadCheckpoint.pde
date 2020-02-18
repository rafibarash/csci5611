/*********************************
 * Globals
 ********************************/
 
// Cloth texture
PImage clothTex;

// Simulation Parameters
int CLOTH_WIDTH = 20;
int CLOTH_HEIGHT = 20;

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
  clothTex = loadImage("texture.jpg");
  background(125);
  lights();
}

void draw() {
  // update light
  lights();
  
  // Update
  for (int i=0; i<200; i++) {
    physics.update((millis() - lastTime)/150000);
  }
  lastTime = millis();
  
  // Render
  background(255);
  physics.render(true);
  
  // Update camera
  camera.Update( 1.0/frameRate );
  
  // Set display title with runtime report
  String runtimeReport = 
        "FPS: " + str(round(frameRate)) +
        ", Cloth Dimensions: " + CLOTH_WIDTH + "x" + CLOTH_WIDTH + "\n";
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
  
}
