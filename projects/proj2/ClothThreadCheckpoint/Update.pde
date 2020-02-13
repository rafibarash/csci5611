/*********************************
 * Update
 * 
 * the main update() method within draw, and its helper functions
 ********************************/
 
void update(float dt){
  //Compute (damped) Hooke's law for each spring
  float stringF1 = -k*((ballY1 - stringTop) - restLen);
  float dampF1 = -kv*(velY1 - 0);
  float forceY1 = stringF1 + dampF1;
  
  float stringF2 = -k*((ballY2 - ballY1) - restLen);
  float dampF2 = -kv*(velY2 - velY1);
  float forceY2 = stringF2 + dampF2;
  
  float stringF3 = -k*((ballY3 - ballY2) - restLen);
  float dampF3 = -kv*(velY3 - velY2);
  float forceY3 = stringF3 + dampF3;
 
  //If are are doing this right, the top spring should be much longer than the bottom
  println("l1:",ballY1 - stringTop, " l2:",ballY2 - ballY1, " l3:",ballY3-ballY2);
  
  //Eulerian integration
  float accY1 = gravity + .5*forceY1/mass - .5*forceY2/mass; 
  velY1 += accY1*dt;
  ballY1 += velY1*dt;
  
  float accY2 = gravity + .5*forceY2/mass - .5*forceY3/mass; 
  velY2 += accY2*dt;
  ballY2 += velY2*dt;
  
  float accY3 = gravity + .5*forceY3/mass; 
  velY3 += accY3*dt;
  ballY3 += velY3*dt;
  
  //Collision detection and response
  if (ballY1+radius > floor){
    velY1 *= -.9;
    ballY1 = floor - radius;
  }
  if (ballY2+radius > floor){
    velY2 *= -.9;
    ballY2 = floor - radius;
  }
  if (ballY3+radius > floor){
    velY3 *= -.9;
    ballY3 = floor - radius;
  }
}
