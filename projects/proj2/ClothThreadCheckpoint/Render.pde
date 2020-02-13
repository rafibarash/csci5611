/*********************************
 * Render
 * 
 * the main render() method within draw, and its helper functions
 ********************************/

void render() {
  fill(0,0,0);
  
  pushMatrix();
  line(200,stringTop,200,ballY1);
  translate(200,ballY1);
  sphere(radius);
  popMatrix();
  
  pushMatrix();
  line(200,ballY1,200,ballY2);
  translate(200,ballY2);
  sphere(radius);
  popMatrix();
  
  pushMatrix();
  line(200,ballY2,200,ballY3);
  translate(200,ballY3);
  sphere(radius);
  popMatrix();
}
