/*********************************
 * Globals
 ********************************/
 
int CLOTH_WIDTH = 10;
 
// Simulation Parameters
Vector g = new Vector(0, 9.8, 0); // gravity
Vector wind;
float d = 5;                     // distance between each point mass vertically and horizontally 
float r = 1;                     // point mass radius, always 0 except when debugging
float l0 = 6;                    // resting length of springs
float m = 2;                     // mass of each point mass
float k = 16;                     // spring constant
float kd = 15;                    // damping constant
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
  
  for (int i=0; i<10; i++) {
    update((millis() - lastTime)/10000);
  }
  lastTime = millis();
  
  render();
  
  camera.Update( 1.0/frameRate );
}
