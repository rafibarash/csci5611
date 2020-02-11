// CONSTANTS
float x = 0, y = 400, z = 10;
float rx = 10, ry = 10, rz = 10;
float speed = 125;
float elapsedTime, startTime;

// Processing function to configure ur project
void setup() {
  size(800, 600, P3D);
  surface.setTitle("Hello world!");
}

// Processing function that is called every frame
void draw() {
  background(0, 0, 0);
  setupLights();
  
  // can use this rather than a constant for dt, for 
  // a constant time of update on different machines
  elapsedTime = millis() - startTime;
  startTime = millis();
  
  update(elapsedTime / 1000);
  
  // Be careful about orer you rotate and trnaslate
  //rotateZ(rz);
  //rotateY(ry);
  //rotateX(rx);
  
  translate(x, y, z);
  
  // triangle(x1, y1, x2, y2, x3, y3), but easier with beginShape() and endShape()
  // sphere(100);
  // noStroke(); // takes borders off sphere's inner triangles
  
  beginShape();
  //fill(122, 0, 25); // fill shape with color
  //vertex(50, 50, z);
  //vertex(100, 250, z);
  //fill(255, 204, 51, z);
  //vertex(600, 400, z);
  
  // Triangle centered around 0, can change with translate() function
  // More vertex's make shape more complex
  vertex(100, 100, 0);
  vertex(-100, -100, 0);
  vertex(100, -100, 0);
  endShape();
  
  // Add keyPressed functionality inside draw to hold a button
  //if (keyPressed && keyCode == UP) {
  //  z += 10;
  //} else if (keyPressed && keyCode == DOWN) {
  //  z -= 10;
  //}
}

// Processing function, auto called on keyPress
void keyPressed() {
  //if (keyCode == UP) {
  //  z += 10;
  //} else if (keyCode == DOWN) {
  //  z -= 10;
  //}
}

// Use helpers to separate state from drawing
void update(float dt) {
  x += speed * dt;
  if (x > 800) speed *= -1;
  if (x < -70) speed *= -1;
  
  //rx += dt * .1;
  //ry += dt * .2;
  //rz  += dt * .4;
  //rx %= 2*PI;
  //ry %= 2*PI;
  //rz %= 2*PI;
}

// Can set lights
void setupLights() {
}
