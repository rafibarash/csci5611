/*********************************
 * Globals
 ********************************/
 
int CLOTH_WIDTH = 10;
 
// Simulation Parameters
Vector g = new Vector(0, 9.8, 0); // gravity
float d = 5;                    // distance between each point mass vertically and horizontally 
float r = 1;                      // point mass radius, always 0 except when debugging
float l0 = 6;                    // resting length of springs
float m = 1;                     // mass of each point mass
float k = 8;                     // spring constant
float kd = 5;                    // damping constant
Point[][] points = new Point[CLOTH_WIDTH][CLOTH_WIDTH];

// camera
Camera camera;

// misc
float lastTime;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(800, 800, P3D);
  surface.setTitle("FPS: " + (int) frameRate + ". Cloth: " + CLOTH_WIDTH);
  initializePoints(d);
  camera = new Camera();
  lastTime = millis();
}

void draw() {
  background(255);
  
  update((millis()-lastTime)/5000); //We're using a fixed, large dt -- this is a bad idea!!
  lastTime = millis();
  
  render();
  
  camera.Update( 1.0/frameRate );
}
