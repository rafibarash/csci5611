/*********************************
 * Globals
 ********************************/

// Simulation Parameters
int CLOTH_WIDTH = 20;
int CLOTH_HEIGHT = 20;
float STRAND_LEN = 10;

// Global Variables
String projectTitle;
Physics physics;
Camera camera;
float lastTime;
PImage clothTex;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(800, 800, P3D);
  projectTitle = "Cloth Sphere Interaction";
  camera = new Camera();
  physics = new Physics();
  clothTex = loadImage("texture.jpg");
  lastTime = millis();
}

void draw() {
  // Update
  for (int i=0; i<70; i++) {
    //physics.update((millis() - lastTime)/180000);
    physics.update(.0002);
  }
  lastTime = millis();
  
  // Render
  background(255);
  lights();
  physics.render();

  // Update camera
  camera.Update( 1.0/frameRate );
  
  // Set display title with runtime report
  String runtimeReport = 
        "FPS: " + str(round(frameRate)) +
        ", Cloth Dimensions: " + CLOTH_WIDTH + "x" + CLOTH_WIDTH + "\n";
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
  
}
