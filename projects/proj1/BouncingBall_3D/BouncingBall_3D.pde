// Created for CSCI 5611
// By Rafi Barash

// Globals
String projectTitle = "Bouncing Ball";
PImage ballImg; 
PShape sphere;
PVector position, velocity, acceleration;
float side = 600;
float radius = 40;

void setup() {
 size(625, 625, P3D);
 noStroke(); //Question: What does this do?
 ballImg = loadImage("basketball.jpeg");
 // set some values
 sphere = createShape(SPHERE, 50); 
 sphere.setTexture(ballImg);
 position = new PVector(width / 2, 200, 300);
 velocity = new PVector(15, 0, -2);
 acceleration = new PVector(0, 9.8, 0);
}

void draw() {
  float startFrame = millis(); //Time how long various components are taking
  
  //Compute the physics update
  handleMouseCollision();
  computePhysics(0.15); //Question: Should this be a fixed number?
  float endPhysics = millis();
  
  drawScene();
  float endFrame = millis();
  
  String runtimeReport = "Frame: "+str(endFrame-startFrame)+"ms,"+
        " Physics: "+ str(endPhysics-startFrame)+"ms,"+
        " FPS: "+ str(round(frameRate)) +"\n";
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
}

// Compute physics update
void computePhysics(float dt){
  // compute and update x values
  float[] updated_x = numericalIntegration(position.x, velocity.x, acceleration.x, dt);
  position.x = updated_x[0]; 
  velocity.x = updated_x[1]; 
  acceleration.x = updated_x[2];
  // compute and update y values
  float[] updated_y = numericalIntegration(position.y, velocity.y, acceleration.y, dt);
  position.y = updated_y[0]; 
  velocity.y = updated_y[1]; 
  acceleration.y = updated_y[2];
  // compute and update z values
  float[] updated_z = numericalIntegration(position.z, velocity.z, acceleration.z, dt);
  position.z = updated_z[0]; 
  velocity.z = updated_z[1]; 
  acceleration.z = updated_z[2];
}

// Compute Eulerian Numerican Integration
float[] numericalIntegration(float pos, float vel, float accel, float dt) {
  pos = pos + vel * dt;  //Question: Why update position before velocity? Does it matter?
  vel = vel + accel * dt;
  
  //Handle collision with wall (update velocity if we hit a bottom or right sides)
  if (pos + radius > side){
    pos = side - radius; //Robust collision check
    vel *= -.95; //Coefficient of restitution (don't bounce back all the way) 
  }
  
  //Handle collision with wall (update velocity if we hit left or top sides)
  if (pos - radius - 25 < 0) {
    pos = radius + 25;
    vel *= -.95;
  }
  
  float[] updatedVals = {pos, vel, accel};
  return updatedVals;
}

// Get mouse position
PVector mousePos() {
  return new PVector(mouseX, mouseY);
}

// Get prev mouse position
PVector pmousePos() {
  return new PVector(pmouseX, pmouseY);
}

// Returns whether or not mouse has collided with ball
boolean isCollision(float mouse_x, float mouse_y) {
  return (abs(mouse_x - position.x) < radius && abs(mouse_y - position.y) < radius);
}

// If new collision with mouse, update velocity
void handleMouseCollision() {
  if (isCollision(mouseX, mouseY) && !isCollision(pmouseX, pmouseY)) {
    // get mouse direction and magnitude
    PVector dir = PVector.sub(mousePos(), pmousePos());
    float normalizer = 0.05;
    float magnitude = dir.mag() * normalizer;
    // update ball velocity
    velocity.x += (dir.x * magnitude);
    velocity.y += (dir.y * magnitude);
  }
}

//Animation Principle: Separate Draw Code
void drawScene(){
  background(255,255,255);
  //fill(0,200,10); 
  
  lights();
  translate(position.x, position.y, position.z); 
  //beginShape();
  //texture(ballImg);
  //sphere(radius);
  //endShape();
  shape(sphere);
}

//Main function which is called every timestep. Here we compute the new physics and draw the scene.
//Additionally, we also compute some timing performance numbers.
