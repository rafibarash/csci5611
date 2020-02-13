//2D Rotational Dynamics
//Ball on Spring (damped) - 2D Motion
//CSCI 5611 Thread Sample Code
// Stephen J. Guy <sjguy@umn.edu>


void setup() {
  size(400, 400, P3D);
  surface.setTitle("Ball on Spring!");
  
}

//0 gravity, pull left
//20 gravity, kick right, stiff

float floor = 400;
float ballX = 200;
float ballY = 200;
float velX = 0; //40
float velY = 0;
float grav = 2000; //0
float radius = 20;
float anchorX = 200;
float anchorY = 100;
float restLen = 150;
float mass = 1;
float k = 160; //1 1000
float kv = 160;

void update(float dt){
  float sx = (ballX - anchorX);
  float sy = (ballY - anchorY);
  float stringLen = sqrt(sx*sx + sy*sy);
  //println(stringLen, " ", restLen);
  float stringF = -k*(stringLen - restLen);
  float dirX = sx/stringLen;
  float dirY = sy/stringLen;
  float projVel = velX*dirX + velY*dirY;
  float dampF = -kv*(projVel - 0);
  
  float springForceX = (stringF+dampF)*dirX;
  float springForceY = (stringF+dampF)*dirY;
  
  velX += (springForceX/mass)*dt;
  velY += ((springForceY+grav)/mass)*dt;
  
  ballX += velX*dt;
  ballY += velY*dt;
  
  if (ballY+radius > floor){
    velY *= -.9;
    ballY = floor - radius;
  }
  
}

void keyPressed() {
  if (keyCode == RIGHT) {
    velX += 100;
  }
  if (keyCode == LEFT) {
    velX -= 100;
  }
}

void draw() {
  background(255,255,255);
  for (int i = 0; i < 10; i++){
    update(1/(10.0*frameRate));
  }
  println(1.0/frameRate);
  fill(0,0,0);
  stroke(5);
  line(anchorX,anchorY,ballX,ballY);
  translate(ballX,ballY);
  noStroke();
  fill(0,200,10);
  sphere(radius);
}
