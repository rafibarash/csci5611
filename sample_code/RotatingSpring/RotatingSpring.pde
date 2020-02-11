//Ball on Spring (damped) - 2D Motion
//CSCI 5611 Thread Sample Code
// Stephen J. Guy <sjguy@umn.edu>

//Create Window
//2D Rotational Dynamics
void setup() {
  size(400, 400, P3D);
  surface.setTitle("Ball on Spring!");
  
}

//Simulation Parameters
float floor = 400;
float grav = 98;
float radius = 20;
float anchorX = 200;
float anchorY = 100;
float restLen = 100;
float k = 1000; //1 1000
float kv = .1;

//Inital positions and velocities of masses
float ballY = 100; //200
float ballX = 100; //200
float velY = 0;
float velX = 0;

void update(float dt){

  //Compute spring length
  float sx = (ballX - anchorX);
  float sy = (ballY - anchorY);
  float stringLen = sqrt(sx*sx + sy*sy);
  //Sprint length should stay near constant with large k and kv
  println(stringLen, " ", restLen);
  
  //Compute (damped) Hooke's law for the spring
  float stringF = -k*(stringLen - restLen);
  
  //Apply force in the direction of the spring
  float dirX = sx/stringLen;
  float dirY = sy/stringLen;
  float dampFX = -kv*(velX - 0);
  float dampFY = -kv*(velY - 0);
  
  //Eulerian integration
  velY += stringF*dirY*dt;
  velY += dampFY*dt;
  
  velX += stringF*dirX*dt;
  velX += dampFX*dt;
  
  velY += grav*dt; //Gravity is only in Y direction
  
  ballX += velX*dt;
  ballY += velY*dt;
  
  //Collision detection and response
  if (ballY+radius > floor){
    velY *= -.9;
    ballY = floor - radius;
  }
  
}

//Allow the user to push the mass with the left and right keys
void keyPressed() {
  if (keyCode == RIGHT) {
    velX += 30;
  }
  if (keyCode == LEFT) {
    velX -= 30;
  }
}

//Draw the scene: one sphere for the mass, and one line connecting it to the anchor
void draw() {
  background(255,255,255);
  update(.05); //We're using a fixed, large dt -- this is a bad idea!!
  fill(0,0,0);
  stroke(5);
  line(anchorX,anchorY,ballX,ballY);
  translate(ballX,ballY);
  noStroke();
  fill(0,200,10);
  sphere(radius);
}
