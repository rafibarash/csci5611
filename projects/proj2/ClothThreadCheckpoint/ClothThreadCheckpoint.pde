/*********************************
 * Globals
 ********************************/
 
// Simulation Parameters
float floor = 500;
float gravity = 10;
float radius = 10;
float stringTop = 50;
float restLen = 40;
float mass = 30; //TRY-IT: How does changing mass affect resting length?
float k = 20; //TRY-IT: How does changing k affect resting length?
float kv = 20;

// Inital positions and velocities of masses
float ballY1 = 200;
float velY1 = 0;
float ballY2 = 250;
float velY2 = 0;
float ballY3 = 300;
float velY3 = 0;

// Misc
Camera camera;

/***********************************
 * Processing
 **********************************/
 
void setup() {
  size(400, 500, P3D);
  surface.setTitle("Cloth Threads Checkpoint");
  camera = new Camera();
}

void draw() {
  background(255);
  //camera.Update(1.0/frameRate);
  //camera.Update( 0.1 );
  
  update(.1); //We're using a fixed, large dt -- this is a bad idea!!
  
  render();
}
