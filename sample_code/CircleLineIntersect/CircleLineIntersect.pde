//Circle Line Intersection
//CSCI 5611 Geometric Processing Sample Code
// Stephen J. Guy <sjguy@umn.edu>

//To use: Click and drag to draw a line with your mouse
//        Line will turn red when overlapping the circle

void setup(){
  size(640,480);
  
  //Initial circle position
  cx = 200;
  cy = 200;
  r = 50;
  
  //Initial line segement position
  x1 = 50; y1 = 50;
  x2 = 300; y2 = 300;
  
  strokeWeight(3); //Draw thicker lines
}

float cx, cy, r; //Circle
float x1, y1, x2, y2; //Line

boolean colliding; //Are the cicle and line colliding

void draw(){
  background(200); //Grey background
  stroke(0,0,0);
  circle(cx,cy,r*2);
  
  //Points in the line segment
  circle(x1,y1,5);
  circle(x2,y2,5);
  
  //Step 1: Compute V - a normalized vector pointing from the start of the linesegment to the end of the line segment
  float vx,vy;
  vx = x2 - x1;
  vy = y2 - y1;
  float lenv = sqrt(vx*vx+vy*vy);
  vx /= lenv; vy /= lenv;
  
  //Step 2: Compute W - a displacement vector pointing from the start of the line segment to the center of the circle
  float wx, wy;
  wx = cx - x1;
  wy = cy - y1;
  
  //Step 3: Solve quadratic equation for intersection point (in terms of V and W)
  float a = 1;  //Lenght of V (we noramlized it)
  float b = -2*(vx*wx + vy*wy); //-2*dot(V,W)
  float c = wx*wx + wy*wy - r*r; //different of squared distances
  
  float d = b*b - 4*a*c; //discriminant 
  
  colliding = false;
  if (d >=0 ){ 
    //If d is positive we know the line is colliding, but we need to check if the collision line within the line segment
    //  ... this means t will be between 0 and the lenth of the line segment
    float t = (-b - sqrt(d))/(2*a); //Optimization: we only need the first collision
    if (t > 0 && t < lenv){
      colliding = true;
    }
  }
  
  //If the linesegment collides draw it red
  if (colliding) stroke(255,0,0);
  else stroke(0,0,0);
  line(x1,y1,x2,y2);
}

//Uesful mouse functions:
//  mousePressed = mouse is pressed
//  mouseDragged = mouse is moving and pressed
//  mouseMoved = mouse is moving and not pressed

//When the user presses the mouse, start the line at a new position
void mousePressed(){
  x1 = mouseX;
  y1 = mouseY;
}

//When the user clicks and drags the mouse, start the end of the line at this new position
void mouseDragged(){
  x2 = mouseX;
  y2 = mouseY;
}
