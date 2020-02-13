import queasycam.*;
/*********************************
 * Globals
 ********************************/
 
int CLOTH_WIDTH = 50;
 
// Simulation Parameters
Vector g = new Vector(0, 5, 0); // gravity
float d = 2;                    // distance between each point mass vertically and horizontally 
float r = 1;                      // point mass radius, always 0 except when debugging
float l0 = 4;                    // resting length of springs
float m = 20;                     // mass of each point mass
float k = 30;                     // spring constant
float kd = 30;                    // damping constant
Point[][] points = new Point[CLOTH_WIDTH][CLOTH_WIDTH];

// camera
QueasyCam cam;

// misc
float lastTime;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(800, 800, P3D);
  surface.setTitle("FPS: " + (int) frameRate + ". Cloth: " + CLOTH_WIDTH);
  initializePoints(d);
  cam = new QueasyCam(this);
  cam.speed = 5;
  cam.sensitivity = 0.5;
  lastTime = millis();
}

void draw() {
  background(255);
  
  update((millis()-lastTime)/1000); //We're using a fixed, large dt -- this is a bad idea!!
  lastTime = millis();
  
  render();
}
